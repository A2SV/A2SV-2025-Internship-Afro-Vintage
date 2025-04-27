'use client';

import { useState, useEffect } from 'react';
import { ItemPreview, Item } from '@/types/marketplace';
import { marketplaceApi } from '@/lib/api/marketplace';
import ItemCard from '@/components/consumer/marketplace/ItemCard';
import Navbar from '@/components/common/Navbar';
import Sidebar from '@/components/common/Sidebar';
import FilterPanel, { FilterValues } from '@/components/consumer/marketplace/FilterPanel';
import ItemDetailsModal from '@/components/consumer/marketplace/ItemDetailsModal';

type MarketplacePageProps = {
  initialItems?: ItemPreview[];
  initialLoading?: boolean;
  initialFilters?: FilterValues;
};

export default function MarketplacePage({
  initialItems = [],
  initialLoading = false,
  initialFilters = {
    search: '',
    category: [],
    size: [],
    priceRange: {
      min: 0,
      max: 10000,
    },
    grade: [],
  }
}: MarketplacePageProps) {
  const [items, setItems] = useState<ItemPreview[]>(initialItems);
  const [filteredItems, setFilteredItems] = useState<ItemPreview[]>(initialItems);
  const [currentPage, setCurrentPage] = useState(1);
  const [loading, setLoading] = useState(initialLoading);
  const [error, setError] = useState<string | null>(null);
  const [totalPages, setTotalPages] = useState(1);
  const [activeFilters, setActiveFilters] = useState<string[]>(initialFilters.category);
  const [showFilterPanel, setShowFilterPanel] = useState(false);
  const [currentFilters, setCurrentFilters] = useState<FilterValues>(initialFilters);
  const [selectedItem, setSelectedItem] = useState<Item | null>(null);
  const [isModalOpen, setIsModalOpen] = useState(false);

  // Add useEffect to load items on mount and handle URL search parameter
  useEffect(() => {
    const searchParams = new URLSearchParams(window.location.search);
    const searchTerm = searchParams.get('search');
    
    if (searchTerm) {
      setCurrentFilters(prev => ({
        ...prev,
        search: searchTerm
      }));
    }
    loadItems(1, initialFilters);
  }, []);

  // Add useEffect to handle search and filtering
  useEffect(() => {
    let filtered = [...items];
    
    // Apply search filter
    if (currentFilters.search) {
      const searchTerm = currentFilters.search.toLowerCase();
      filtered = filtered.filter(item => {
        const titleMatch = (item.title || '').toLowerCase().includes(searchTerm);
        const categoryMatch = (item.category || '').toLowerCase().includes(searchTerm);
        const descriptionMatch = (item.description || '').toLowerCase().includes(searchTerm);
        return titleMatch || categoryMatch || descriptionMatch;
      });
    }
    
    // Apply category filter
    if (currentFilters.category.length > 0) {
      filtered = filtered.filter(item => 
        currentFilters.category.includes(item.category || '')
      );
    }
    
    // Apply size filter
    if (currentFilters.size.length > 0) {
      filtered = filtered.filter(item => 
        currentFilters.size.includes(item.size || '')
      );
    }
    
    // Apply grade filter
    if (currentFilters.grade.length > 0) {
      filtered = filtered.filter(item => 
        currentFilters.grade.includes(item.grade || '')
      );
    }
    
    // Apply price range filter
    filtered = filtered.filter(item => 
      item.price >= currentFilters.priceRange.min && 
      item.price <= currentFilters.priceRange.max
    );
    
    setFilteredItems(filtered);
    
    // Update active filters display
    const newActiveFilters = [
      ...currentFilters.category,
      ...currentFilters.size,
      ...currentFilters.grade,
      ...(currentFilters.priceRange.min > 0 ? [`$${currentFilters.priceRange.min}+`] : []),
      ...(currentFilters.priceRange.max < 10000 ? [`$${currentFilters.priceRange.max}-`] : []),
      ...(currentFilters.search ? [currentFilters.search] : [])
    ];
    setActiveFilters(newActiveFilters);
  }, [currentFilters, items]);

  // Add useEffect to handle search event
  useEffect(() => {
    const handleSearch = (e: CustomEvent) => {
      setCurrentFilters(prev => ({
        ...prev,
        search: e.detail.searchTerm
      }));
    };

    const marketplacePage = document.querySelector('[data-marketplace-page]');
    if (marketplacePage) {
      marketplacePage.addEventListener('marketplace-search', handleSearch as EventListener);
    }

    return () => {
      if (marketplacePage) {
        marketplacePage.removeEventListener('marketplace-search', handleSearch as EventListener);
      }
    };
  }, []);

  const handleFilterChange = (filters: FilterValues) => {
    setCurrentPage(1);
    setCurrentFilters(filters);
  };

  const loadItems = async (page: number, filters: FilterValues) => {
    try {
      setLoading(true);
      const response = await marketplaceApi.getProducts({ 
        page, 
        limit: 12
      });
      setItems(response.items);
      setFilteredItems(response.items);
      setTotalPages(Math.ceil(response.total / 12));
      setError(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load products');
      setItems([]);
      setFilteredItems([]);
    } finally {
      setLoading(false);
    }
  };

  const removeFilter = (filter: string) => {
    setCurrentFilters(prev => {
      const newFilters = { ...prev };
      
      // Check which type of filter it is and remove it
      if (prev.category.includes(filter)) {
        newFilters.category = prev.category.filter(f => f !== filter);
      } else if (prev.size.includes(filter)) {
        newFilters.size = prev.size.filter(f => f !== filter);
      } else if (prev.grade.includes(filter)) {
        newFilters.grade = prev.grade.filter(f => f !== filter);
      } else if (filter.startsWith('$')) {
        // Handle price range filters
        if (filter.endsWith('+')) {
          newFilters.priceRange.min = 0;
        } else if (filter.endsWith('-')) {
          newFilters.priceRange.max = 10000;
        }
      } else {
        // If it's not any of the above, it's probably a search term
        newFilters.search = '';
      }
      
      return newFilters;
    });
  };

  const clearAllFilters = () => {
    setCurrentFilters({
      search: '',
      category: [],
      size: [],
      priceRange: {
        min: 0,
        max: 10000,
      },
      grade: [],
    });
  };

  const handleItemClick = (item: ItemPreview) => {
    setSelectedItem({
      id: item.id,
      name: item.title,
      price: item.price,
      image: item.thumbnailUrl,
      description: item.description,
      category: item.category,
      grade: item.grade,
      status: 'available',
      seller_id: item.resellerId,
      rating: item.rating,
      resellerName: item.resellerName
    });
    setIsModalOpen(true);
  };

  if (error) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-bold text-red-600 mb-4">Error</h2>
          <p className="text-gray-600">{error}</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50" data-marketplace-page>
      <Navbar onFilterClick={() => setShowFilterPanel(!showFilterPanel)} />
      <Sidebar />
      <main className="ml-64 pt-16">
        <div className="p-8">
          <div className="max-w-7xl mx-auto">
            <div className="flex gap-8">
              {/* Filter Panel */}
              {showFilterPanel && (
                <div className="w-64 flex-shrink-0">
                  <FilterPanel onFilterChange={handleFilterChange} onClearAll={clearAllFilters} />
                </div>
              )}

              {/* Content */}
              <div className="flex-1">
                {/* Active Filters */}
                <div className="mb-6">
                  <div className="flex justify-between items-center mb-4">
                    <h2 className="text-lg font-medium">Active Filters</h2>
                    <button 
                      onClick={clearAllFilters}
                      className="text-sm text-teal-600 hover:text-teal-700"
                    >
                      Clear all
                    </button>
                  </div>
                  <div className="flex flex-wrap gap-2">
                    {activeFilters.map((filter) => (
                      <div 
                        key={filter}
                        className="flex items-center gap-2 bg-white border border-gray-200 px-3 py-1.5 rounded-full"
                      >
                        <span className="text-sm font-medium text-gray-900">{filter}</span>
                        <button 
                          onClick={() => removeFilter(filter)}
                          className="text-gray-400 hover:text-gray-600"
                        >
                          <svg className="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M6 18L18 6M6 6l12 12" />
                          </svg>
                        </button>
                      </div>
                    ))}
                  </div>
                </div>

                {/* Items Grid */}
                {filteredItems.length === 0 ? (
                  <div className="text-center py-12">
                    <h3 className="text-lg font-medium text-gray-900">No items found</h3>
                    <p className="mt-1 text-sm text-gray-500">Try adjusting your filters or search terms</p>
                  </div>
                ) : (
                  <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
                    {filteredItems.map((item) => (
                      <ItemCard key={item.id} item={item} onItemClick={handleItemClick} />
                    ))}
                  </div>
                )}

                {/* Loading State */}
                {loading && (
                  <div className="flex justify-center mt-8">
                    <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-gray-900"></div>
                  </div>
                )}

                {/* Pagination */}
                {!loading && totalPages > 1 && (
                  <div className="flex justify-center items-center gap-2 mt-8">
                    <button
                      onClick={() => {
                        if (currentPage > 1) {
                          setCurrentPage(currentPage - 1);
                          loadItems(currentPage - 1, currentFilters);
                        }
                      }}
                      className="px-3 py-1.5 text-sm font-medium text-gray-600 hover:text-gray-800"
                    >
                      Previous
                    </button>
                    {Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => (
                      <button
                        key={page}
                        onClick={() => {
                          setCurrentPage(page);
                          loadItems(page, currentFilters);
                        }}
                        className={`min-w-[32px] h-8 flex items-center justify-center rounded-md text-sm font-medium ${
                          currentPage === page
                            ? 'bg-teal-600 text-white'
                            : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
                        }`}
                      >
                        {page}
                      </button>
                    ))}
                    <button
                      onClick={() => {
                        if (currentPage < totalPages) {
                          setCurrentPage(currentPage + 1);
                          loadItems(currentPage + 1, currentFilters);
                        }
                      }}
                      className="px-3 py-1.5 text-sm font-medium text-gray-600 hover:text-gray-800"
                    >
                      Next
                    </button>
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      </main>
      {selectedItem && (
        <ItemDetailsModal
          item={selectedItem}
          isOpen={isModalOpen}
          onClose={() => setIsModalOpen(false)}
        />
      )}
    </div>
  );
} 
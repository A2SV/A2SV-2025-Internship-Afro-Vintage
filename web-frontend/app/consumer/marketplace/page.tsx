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
  const [isSidebarCollapsed, setIsSidebarCollapsed] = useState(false);

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

  // Add event listener for sidebar collapse state
  useEffect(() => {
    const handleSidebarCollapse = (e: CustomEvent) => {
      setIsSidebarCollapsed(e.detail.isCollapsed);
    };

    window.addEventListener('sidebar-collapse', handleSidebarCollapse as EventListener);
    return () => {
      window.removeEventListener('sidebar-collapse', handleSidebarCollapse as EventListener);
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
      <main className={`transition-all duration-300 pt-16 ${
        isSidebarCollapsed ? 'md:ml-20' : 'md:ml-64'
      }`}>
        <div className="p-4 md:p-8">
          <div className="max-w-7xl mx-auto">
            <div className="flex flex-col lg:flex-row gap-4 lg:gap-8">
              {/* Filter Panel */}
              {showFilterPanel && (
                <div className="w-full lg:w-64 flex-shrink-0">
                  <FilterPanel onFilterChange={handleFilterChange} onClearAll={clearAllFilters} />
                </div>
              )}

              {/* Content */}
              <div className="flex-1">
                {/* Active Filters */}
                <div className="mb-6">
                  <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-4">
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
                        className="flex items-center gap-2 px-3 py-1 bg-teal-50 text-teal-700 rounded-full text-sm"
                      >
                        <span>{filter}</span>
                        <button
                          onClick={() => removeFilter(filter)}
                          className="hover:text-teal-900"
                        >
                          ×
                        </button>
                      </div>
                    ))}
                  </div>
                </div>

                {/* Grid of Items */}
                {loading ? (
                  <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
                    {[...Array(8)].map((_, i) => (
                      <div key={i} className="animate-pulse">
                        <div className="bg-gray-200 rounded-lg aspect-square mb-2"></div>
                        <div className="h-4 bg-gray-200 rounded w-3/4 mb-2"></div>
                        <div className="h-4 bg-gray-200 rounded w-1/2"></div>
                      </div>
                    ))}
                  </div>
                ) : filteredItems.length > 0 ? (
                  <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
                    {filteredItems.map((item) => (
                      <ItemCard
                        key={item.id}
                        item={item}
                        onItemClick={() => handleItemClick(item)}
                      />
                    ))}
                  </div>
                ) : (
                  <div className="text-center py-12">
                    <h3 className="text-lg font-medium text-gray-900 mb-2">No items found</h3>
                    <p className="text-gray-500">Try adjusting your filters or search terms</p>
                  </div>
                )}

                {/* Pagination */}
                {totalPages > 1 && (
                  <div className="mt-8 flex justify-center">
                    <nav className="flex items-center gap-2">
                      <button
                        onClick={() => setCurrentPage(prev => Math.max(prev - 1, 1))}
                        disabled={currentPage === 1}
                        className="px-3 py-1 rounded border border-gray-300 text-sm disabled:opacity-50"
                      >
                        Previous
                      </button>
                      <span className="text-sm text-gray-600">
                        Page {currentPage} of {totalPages}
                      </span>
                      <button
                        onClick={() => setCurrentPage(prev => Math.min(prev + 1, totalPages))}
                        disabled={currentPage === totalPages}
                        className="px-3 py-1 rounded border border-gray-300 text-sm disabled:opacity-50"
                      >
                        Next
                      </button>
                    </nav>
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      </main>

      {/* Item Details Modal */}
      {selectedItem && (
        <ItemDetailsModal
          item={selectedItem}
          isOpen={isModalOpen}
          onClose={() => {
            setIsModalOpen(false);
            setSelectedItem(null);
          }}
        />
      )}
    </div>
  );
} 
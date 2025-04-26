'use client';

import { useState, useEffect } from 'react';
import { ItemPreview, Item } from '@/types/marketplace';
import { marketplaceApi } from '@/lib/api/marketplace';
import ItemCard from '@/components/marketplace/ItemCard';
import Navbar from '@/components/layout/Navbar';
import Sidebar from '@/components/layout/Sidebar';
import FilterPanel, { FilterValues } from '@/components/marketplace/FilterPanel';
import ItemDetailsModal from '@/components/marketplace/ItemDetailsModal';

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
      max: 1000,
    },
    grade: [],
  }
}: MarketplacePageProps) {
  const [items, setItems] = useState<ItemPreview[]>(initialItems);
  const [currentPage, setCurrentPage] = useState(1);
  const [loading, setLoading] = useState(initialLoading);
  const [error, setError] = useState<string | null>(null);
  const [totalPages, setTotalPages] = useState(1);
  const [activeFilters, setActiveFilters] = useState<string[]>(initialFilters.category);
  const [showFilterPanel, setShowFilterPanel] = useState(false);
  const [currentFilters, setCurrentFilters] = useState<FilterValues>(initialFilters);
  const [selectedItem, setSelectedItem] = useState<Item | null>(null);
  const [isModalOpen, setIsModalOpen] = useState(false);

  // Add useEffect to load items on mount
  useEffect(() => {
    loadItems(1, initialFilters);
  }, []); // Empty dependency array means this runs once on mount

  const loadItems = async (page: number, filters: FilterValues) => {
    try {
      setLoading(true);
      setCurrentFilters(filters);
      const response = await marketplaceApi.getProducts({ 
        page, 
        limit: 12,
        minPrice: filters.priceRange.min,
        maxPrice: filters.priceRange.max,
        type: filters.category[0] // Use first category as type
      });
      setItems(response.items);
      setTotalPages(Math.ceil(response.total / 12));
      setError(null); // Clear any previous errors
      
      // Update active filters display
      const newActiveFilters = [
        ...filters.category,
        ...filters.size,
        ...filters.grade,
        ...(filters.priceRange.min > 0 ? [`$${filters.priceRange.min}+`] : []),
        ...(filters.priceRange.max < 1000 ? [`$${filters.priceRange.max}-`] : [])
      ];
      setActiveFilters(newActiveFilters);
    } catch (err) {
      console.error('Error loading items:', err);
      setError(err instanceof Error ? err.message : 'Failed to load products');
      setItems([]); // Clear items on error
    } finally {
      setLoading(false);
    }
  };

  const handleFilterChange = (filters: FilterValues) => {
    setCurrentPage(1);
    loadItems(1, filters);
  };

  const removeFilter = (filter: string) => {
    // This is a simplified version - in a real app, you'd need to update the actual filter state
    setActiveFilters(activeFilters.filter(f => f !== filter));
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
    <div className="min-h-screen bg-gray-50">
      <Navbar onFilterClick={() => setShowFilterPanel(!showFilterPanel)} />
      <Sidebar />
      <main className="ml-64 pt-16">
        <div className="p-8">
          <div className="max-w-7xl mx-auto">
            <div className="flex gap-8">
              {/* Filter Panel */}
              {showFilterPanel && (
                <div className="w-64 flex-shrink-0">
                  <FilterPanel onFilterChange={handleFilterChange} />
                </div>
              )}

              {/* Content */}
              <div className="flex-1">
                {/* Active Filters */}
                <div className="mb-6">
                  <div className="flex justify-between items-center mb-4">
                    <h2 className="text-lg font-medium">Type</h2>
                    <button className="text-sm text-gray-600 hover:text-gray-900">
                      View All
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
                {items.length === 0 ? (
                  <div className="text-center py-12">
                    <h3 className="text-lg font-medium text-gray-900">No items found</h3>
                    <p className="mt-1 text-sm text-gray-500">Try adjusting your filters or search terms</p>
                  </div>
                ) : (
                  <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
                    {items.map((item) => (
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
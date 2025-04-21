import { ItemPreview } from '@/types/marketplace';

export interface MarketplaceFilters {
  page: number;
  limit: number;
  search?: string;
  category?: string[];
  size?: string[];
  minPrice?: number;
  maxPrice?: number;
  grade?: string[];
}

export interface MarketplaceResponse {
  items: ItemPreview[];
  total: number;
}

export const fetchMarketplaceItems = async (filters: MarketplaceFilters): Promise<MarketplaceResponse> => {
  try {
    // TODO: Replace with actual API call
    const response = await fetch('/api/marketplace/items?' + new URLSearchParams({
      page: filters.page.toString(),
      limit: filters.limit.toString(),
      ...(filters.search && { search: filters.search }),
      ...(filters.category?.length && { category: filters.category.join(',') }),
      ...(filters.size?.length && { size: filters.size.join(',') }),
      ...(filters.minPrice !== undefined && { minPrice: filters.minPrice.toString() }),
      ...(filters.maxPrice !== undefined && { maxPrice: filters.maxPrice.toString() }),
      ...(filters.grade?.length && { grade: filters.grade.join(',') })
    }));

    if (!response.ok) {
      throw new Error('Failed to fetch items');
    }

    return await response.json();
  } catch (error) {
    console.error('Error fetching marketplace items:', error);
    throw error;
  }
}; 
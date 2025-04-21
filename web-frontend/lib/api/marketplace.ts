import { MarketplaceResponse, MarketplaceFilters } from '@/types/marketplace';

const API_URL = process.env.NEXT_PUBLIC_API_URL;

export async function fetchMarketplaceItems(filters: MarketplaceFilters = {}): Promise<MarketplaceResponse> {
  const queryParams = new URLSearchParams();
  
  if (filters.page) queryParams.append('page', filters.page.toString());
  if (filters.limit) queryParams.append('limit', filters.limit.toString());
  if (filters.minPrice) queryParams.append('minPrice', filters.minPrice.toString());
  if (filters.maxPrice) queryParams.append('maxPrice', filters.maxPrice.toString());
  if (filters.type) queryParams.append('type', filters.type);

  const response = await fetch(`${API_URL}/marketplace/items?${queryParams.toString()}`);
  
  if (!response.ok) {
    throw new Error('Unable to load items. Please try again later.');
  }

  return response.json();
} 
export interface ItemPreview {
  id: string;
  title: string;
  price: number;
  thumbnailUrl: string;
  condition: string;
  rating: number;
  status: 'available' | 'sold';
}

export interface MarketplaceResponse {
  items: ItemPreview[];
  total: number;
  page: number;
  limit: number;
}

export interface MarketplaceFilters {
  page?: number;
  limit?: number;
  minPrice?: number;
  maxPrice?: number;
  type?: string;
} 
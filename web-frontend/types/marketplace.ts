export type ItemPreview = {
  id: string;
  title: string;
  price: number;
  thumbnailUrl: string;
  rating: number;
  description: string;
  category: string;
  size: string;
  grade: string;
};

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
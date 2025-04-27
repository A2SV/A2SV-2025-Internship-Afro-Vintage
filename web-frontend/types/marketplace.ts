export interface ItemPreview {
  id: string;
  title: string;
  price: number;
  thumbnailUrl: string;
  resellerId: string;
  resellerName: string;
  status: 'available' | 'sold';
  description: string;
  category: string;
  grade: string;
  rating?: number;
  size?: string;
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

export type Item = {
  id: string;
  name: string;
  price: number;
  image: string;
  description: string;
  category: string;
  size?: string;
  grade?: string;
  seller_id: string;
  status: 'available' | 'sold' | 'reserved';
}; 
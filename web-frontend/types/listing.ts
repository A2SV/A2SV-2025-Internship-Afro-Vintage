import { ItemStatus } from '../config/status';
import { User } from './user';

export interface Listing {
  id: string;
  resellerId: string;
  bundleItemId: string;
  title: string;
  description: string;
  price: number;
  status: ItemStatus;
  images: string[];
  category: string;
  condition: string;
  brand?: string;
  size?: string;
  color?: string;
  material?: string;
  createdAt: Date;
  updatedAt: Date;
  reseller?: User;
}

export interface CreateListingInput {
  bundleItemId: string;
  title: string;
  description: string;
  price: number;
  images: string[];
  category: string;
  condition: string;
  brand?: string;
  size?: string;
  color?: string;
  material?: string;
}

export interface UpdateListingInput extends Partial<CreateListingInput> {
  status?: ItemStatus;
}

export interface ListingFilters {
  category?: string;
  condition?: string;
  minPrice?: number;
  maxPrice?: number;
  brand?: string;
  size?: string;
  color?: string;
  material?: string;
} 
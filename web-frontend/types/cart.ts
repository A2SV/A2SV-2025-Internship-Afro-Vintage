import { Listing } from './listing';

export interface CartItem {
  id: string;
  listingId: string;
  quantity: number;
  price: number;
  listing?: Listing;
}

export interface Cart {
  id: string;
  userId: string;
  items: CartItem[];
  total: number;
  createdAt: Date;
  updatedAt: Date;
}

export interface AddToCartInput {
  listingId: string;
  quantity: number;
}

export interface UpdateCartItemInput {
  quantity: number;
}

export interface CartSummary {
  subtotal: number;
  shipping: number;
  tax: number;
  total: number;
} 
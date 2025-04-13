import { OrderStatus } from '../config/status';
import { Address } from './user';
import { Listing } from './listing';

export interface OrderItem {
  id: string;
  orderId: string;
  listingId: string;
  quantity: number;
  price: number;
  listing?: Listing;
}

export interface Order {
  id: string;
  userId: string;
  items: OrderItem[];
  status: OrderStatus;
  shippingAddress: Address;
  billingAddress: Address;
  subtotal: number;
  shipping: number;
  tax: number;
  total: number;
  trackingNumber?: string;
  estimatedDelivery?: Date;
  createdAt: Date;
  updatedAt: Date;
}

export interface CreateOrderInput {
  items: {
    listingId: string;
    quantity: number;
  }[];
  shippingAddress: Address;
  billingAddress: Address;
}

export interface UpdateOrderInput {
  status?: OrderStatus;
  trackingNumber?: string;
  estimatedDelivery?: Date;
}

export interface OrderFilters {
  status?: OrderStatus;
  startDate?: Date;
  endDate?: Date;
} 
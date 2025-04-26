export type OrderStatus = 'PENDING_DELIVERY' | 'DELIVERED' | 'FAILED' | 'SHIPPED';
export type PaymentStatus = 'PAID' | 'PENDING' | 'FAILED';

export interface OrderItem {
  id: string;
  name: string;
  price: number;
  imageUrl?: string;
  hasReview?: boolean;
}

export interface Order {
  id: string;
  items: OrderItem[];
  total: number;
  status: OrderStatus;
  paymentStatus: PaymentStatus;
  createdAt: string;
  estimatedDeliveryTime?: string;
  title?: string;
} 
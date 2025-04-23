export type PaymentStatus = 'PAID' | 'PENDING' | 'FAILED';

export interface OrderItem {
  id: string;
  name: string;
  price: number;
  hasReview?: boolean;
}

export interface Order {
  id: string;
  items: OrderItem[];
  total: number;
  status: 'PENDING_DELIVERY' | 'DELIVERED' | 'FAILED';
  paymentStatus: PaymentStatus;
  createdAt: string;
  estimatedDeliveryTime?: string;
} 
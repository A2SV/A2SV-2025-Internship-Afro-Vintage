export type OrderStatus = 'PENDING_DELIVERY' | 'DELIVERED' | 'FAILED' | 'SHIPPED';
export type PaymentStatus = 'PAID' | 'PENDING' | 'FAILED';

export interface Order {
  id: string;
  title?: string;
  price: number;
  status: OrderStatus;
  paymentStatus: PaymentStatus;
  createdAt: string;
  estimatedDeliveryTime?: string;
  imageUrl?: string;
  hasReview?: boolean;
  resellerName?: string;
} 
export type OrderStatus = 'completed' | 'shipped' | 'delivered' | 'failed';

export interface Order {
  id: string;
  title: string;
  price: number;
  imageUrl: string;
  status: OrderStatus;
  purchaseDate: string;
  estimatedDeliveryTime: string;
} 
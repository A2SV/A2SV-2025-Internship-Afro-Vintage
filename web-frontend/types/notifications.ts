export interface Notification {
  id: string;
  type: 'DELIVERY' | 'ORDER' | 'REVIEW';
  title: string;
  message: string;
  orderId?: string;
  itemId?: string;
  read: boolean;
  createdAt: string;
}

export interface NotificationPreferences {
  inApp: boolean;
  email: boolean;
} 
import { Order, OrderStatus, PaymentStatus } from '../../types/order';

const API_URL = process.env.NEXT_PUBLIC_API_URL

export const orderApi = {
  async getOrderHistory(): Promise<Order[]> {
    try {
      const token = localStorage.getItem('token');
      if (!token) {
        throw new Error('Authentication required');
      }

      const response = await fetch(`${API_URL}/orders/history`, {
        headers: {
          'Accept': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
      });

      if (!response.ok) {
        const errorData = await response.json().catch(() => null);
        console.error('Server response error:', {
          status: response.status,
          statusText: response.statusText,
          error: errorData
        });
        throw new Error(errorData?.error || 'Failed to fetch orders');
      }

      const data = await response.json();
      const orders = data.data?.orders || [];

      if (!Array.isArray(orders)) {
        console.error('Orders is not an array:', orders);
        return [];
      }

      return orders.map((orderData: any) => {
        const order = orderData.order;
        const product = orderData.products?.[0];
        return {
          id: order.id,
          title: product?.title || 'Unknown Product',
          price: order.total_price,
          imageUrl: product?.image_url,
          status: (order.status || 'PENDING_DELIVERY').toLowerCase() as OrderStatus,
          paymentStatus: (order.paymentStatus || 'PENDING') as PaymentStatus,
          createdAt: order.created_at,
          estimatedDeliveryTime: order.estimatedDeliveryTime,
          resellerName: orderData.resellerUsername || 'Unknown Seller'
        };
      });
    } catch (error) {
      console.error('Error fetching orders:', error);
      throw error;
    }
  },
}; 
import { Order } from '../../types/order';

const API_URL = process.env.NEXT_PUBLIC_API_URL

export const orderApi = {
  async getOrderHistory(): Promise<Order[]> {
    try {
      const token = localStorage.getItem('token');
      console.log('Token found:', !!token);
      if (!token) {
        throw new Error('Authentication required');
      }

      console.log('Fetching orders from:', `${API_URL}/orders/history`);
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
      console.log('Raw API response:', data);

      // Handle the response data structure
      const orders = Array.isArray(data) ? data : (data.data || []);
      console.log('Processed orders:', orders);

      return orders.map((order: any) => ({
        id: order.orderId || order._id,
        title: order.product_title || 'Untitled Product',
        price: order.price || 0,
        imageUrl: order.image_url || '/images/placeholder.png',
        status: (order.status || 'completed').toLowerCase(),
        estimatedDeliveryTime: order.estimatedDeliveryTime || '3 minutes',
      }));
    } catch (error) {
      console.error('Error fetching orders:', error);
      throw error;
    }
  },
}; 
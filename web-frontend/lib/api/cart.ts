import { Item } from '@/types/marketplace';

const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8080';

export interface CartResponse {
  success: boolean;
  message: string;
  data?: any;
}

export const cartApi = {
  async addToCart(listingId: string): Promise<CartResponse> {
    try {
      const response = await fetch(`${API_URL}/api/cart/items`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('token')}`,
        },
        body: JSON.stringify({ listing_id: listingId }),
      });

      if (!response.ok) {
        const error = await response.json();
        return { success: false, message: error.error || 'Failed to add item to cart' };
      }

      return { success: true, message: 'Item added to cart successfully' };
    } catch (error) {
      return { success: false, message: 'Failed to add item to cart' };
    }
  },

  async getCartItems(): Promise<Item[]> {
    try {
      const response = await fetch(`${API_URL}/api/cart`, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('token')}`,
        },
      });

      if (!response.ok) {
        throw new Error('Failed to fetch cart items');
      }

      const data = await response.json();
      return data.map((item: any) => ({
        id: item.listing_id,
        title: item.title,
        price: item.price,
        imageUrl: item.image_url,
        grade: item.grade,
      }));
    } catch (error) {
      console.error('Error fetching cart items:', error);
      return [];
    }
  },

  async removeFromCart(listingId: string): Promise<CartResponse> {
    try {
      const response = await fetch(`${API_URL}/api/cart/items/${listingId}`, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('token')}`,
        },
      });

      if (!response.ok) {
        const error = await response.json();
        return { success: false, message: error.error || 'Failed to remove item from cart' };
      }

      return { success: true, message: 'Item removed from cart successfully' };
    } catch (error) {
      return { success: false, message: 'Failed to remove item from cart' };
    }
  },

  async checkout(): Promise<CartResponse> {
    try {
      const response = await fetch(`${API_URL}/api/checkout`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('token')}`,
        },
      });

      if (!response.ok) {
        const error = await response.json();
        return { success: false, message: error.error || 'Checkout failed' };
      }

      const data = await response.json();
      return { success: true, message: 'Checkout successful', data };
    } catch (error) {
      return { success: false, message: 'Checkout failed' };
    }
  },
}; 
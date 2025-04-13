import { create } from 'zustand';
import { Cart, CartItem, AddToCartInput, UpdateCartItemInput } from '../types/cart';
import api from '../lib/axios';

interface CartStore {
  cart: Cart | null;
  loading: boolean;
  error: string | null;
  fetchCart: () => Promise<void>;
  addToCart: (input: AddToCartInput) => Promise<void>;
  updateCartItem: (itemId: string, input: UpdateCartItemInput) => Promise<void>;
  removeFromCart: (itemId: string) => Promise<void>;
  clearCart: () => Promise<void>;
}

export const useCartStore = create<CartStore>()((set) => ({
  cart: null,
  loading: false,
  error: null,

  fetchCart: async () => {
    try {
      set({ loading: true, error: null });
      const response = await api.get<{ cart: Cart }>('/cart');
      set({ cart: response.data.cart });
    } catch (err) {
      set({ error: 'Failed to fetch cart' });
    } finally {
      set({ loading: false });
    }
  },

  addToCart: async (input: AddToCartInput) => {
    try {
      set({ loading: true, error: null });
      const response = await api.post<{ cart: Cart }>('/cart/items', input);
      set({ cart: response.data.cart });
    } catch (err) {
      set({ error: 'Failed to add item to cart' });
      throw err;
    } finally {
      set({ loading: false });
    }
  },

  updateCartItem: async (itemId: string, input: UpdateCartItemInput) => {
    try {
      set({ loading: true, error: null });
      const response = await api.patch<{ cart: Cart }>(`/cart/items/${itemId}`, input);
      set({ cart: response.data.cart });
    } catch (err) {
      set({ error: 'Failed to update cart item' });
      throw err;
    } finally {
      set({ loading: false });
    }
  },

  removeFromCart: async (itemId: string) => {
    try {
      set({ loading: true, error: null });
      const response = await api.delete<{ cart: Cart }>(`/cart/items/${itemId}`);
      set({ cart: response.data.cart });
    } catch (err) {
      set({ error: 'Failed to remove item from cart' });
      throw err;
    } finally {
      set({ loading: false });
    }
  },

  clearCart: async () => {
    try {
      set({ loading: true, error: null });
      await api.delete('/cart');
      set({ cart: null });
    } catch (err) {
      set({ error: 'Failed to clear cart' });
      throw err;
    } finally {
      set({ loading: false });
    }
  },
})); 
'use client';

import { createContext, useContext, useState, ReactNode, useEffect } from 'react';
import { Item } from '@/types/marketplace';
import { cartService } from '@/services/cartService';

interface CartContextType {
  items: Item[];
  addToCart: (item: Item) => Promise<{ success: boolean; message: string }>;
  removeFromCart: (itemId: string) => Promise<{ success: boolean; message: string }>;
  isInCart: (itemId: string) => boolean;
  checkout: () => Promise<{ success: boolean; message: string; data?: any }>;
  loading: boolean;
}

const CartContext = createContext<CartContextType | undefined>(undefined);

export function CartProvider({ children }: { children: ReactNode }) {
  const [cartItems, setCartItems] = useState<Item[]>([]);
  const [loading, setLoading] = useState(true);

  // Load cart items on mount
  useEffect(() => {
    loadCartItems();
  }, []);

  const loadCartItems = async () => {
    try {
      const items = await cartService.getCartItems();
      setCartItems(items);
    } catch (error) {
      console.error('Error loading cart items:', error);
    } finally {
      setLoading(false);
    }
  };

  const addToCart = async (item: Item) => {
    if (cartItems.some(cartItem => cartItem.id === item.id)) {
      return { 
        success: false, 
        message: 'This item is already in your cart' 
      };
    }

    const result = await cartService.addToCart(item.id);
    if (result.success) {
      setCartItems(prev => [...prev, item]);
    }
    return result;
  };

  const removeFromCart = async (itemId: string) => {
    const result = await cartService.removeFromCart(itemId);
    if (result.success) {
      setCartItems(prev => prev.filter(item => item.id !== itemId));
    }
    return result;
  };

  const isInCart = (itemId: string) => {
    return cartItems.some(item => item.id === itemId);
  };

  const checkout = async () => {
    const result = await cartService.checkout();
    if (result.success) {
      setCartItems([]); // Clear cart after successful checkout
    }
    return result;
  };

  return (
    <CartContext.Provider value={{ 
      items: cartItems, 
      addToCart, 
      removeFromCart, 
      isInCart,
      checkout,
      loading
    }}>
      {children}
    </CartContext.Provider>
  );
}

export function useCart() {
  const context = useContext(CartContext);
  if (context === undefined) {
    throw new Error('useCart must be used within a CartProvider');
  }
  return context;
} 
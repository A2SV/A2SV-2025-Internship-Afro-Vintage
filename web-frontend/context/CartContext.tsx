'use client';

import { createContext, useContext, useState, ReactNode } from 'react';
import { Item } from '@/types/marketplace';

interface CartContextType {
  items: Item[];
  addToCart: (item: Item) => { success: boolean; message: string };
  removeFromCart: (itemId: string) => void;
  isInCart: (itemId: string) => boolean;
}

const CartContext = createContext<CartContextType | undefined>(undefined);

export function CartProvider({ children }: { children: ReactNode }) {
  const [cartItems, setCartItems] = useState<Item[]>([]);

  const addToCart = (item: Item) => {
    if (cartItems.some(cartItem => cartItem.id === item.id)) {
      return { 
        success: false, 
        message: 'This item is already in your cart' 
      };
    }

    setCartItems(prev => [...prev, item]);
    return { 
      success: true, 
      message: 'Item added to cart successfully' 
    };
  };

  const removeFromCart = (itemId: string) => {
    setCartItems(prev => prev.filter(item => item.id !== itemId));
  };

  const isInCart = (itemId: string) => {
    return cartItems.some(item => item.id === itemId);
  };

  return (
    <CartContext.Provider value={{ 
      items: cartItems, 
      addToCart, 
      removeFromCart, 
      isInCart 
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
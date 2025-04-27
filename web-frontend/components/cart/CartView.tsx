'use client';

import React from 'react';
import Image from 'next/image';
import { X, Loader2 } from 'lucide-react';
import { useCart } from '@/context/CartContext';
import { useState } from 'react';
import CheckoutSimulation from './CheckoutSimulation';

type CartViewProps = {
  isOpen: boolean;
  onClose: () => void;
};

export default function CartView({ isOpen, onClose }: CartViewProps) {
  const { items, removeFromCart } = useCart();
  const [isRemoving, setIsRemoving] = useState<string | null>(null);
  const [showCheckout, setShowCheckout] = useState(false);
  const total = items.reduce((sum, item) => sum + item.price, 0);

  const handleRemove = async (itemId: string) => {
    setIsRemoving(itemId);
    try {
      await removeFromCart(itemId);
    } finally {
      setIsRemoving(null);
    }
  };

  if (!isOpen) return null;

  return (
    <>
      <div className="fixed inset-y-0 right-0 w-96 bg-white shadow-xl z-50">
        <div className="h-full flex flex-col">
          {/* Header */}
          <div className="p-4 border-b flex items-center justify-between">
            <h2 className="text-xl font-medium">Shopping Cart</h2>
            <button
              onClick={onClose}
              className="text-gray-400 hover:text-gray-600"
            >
              <X className="w-6 h-6" />
            </button>
          </div>

          {/* Cart Items */}
          <div className="flex-1 overflow-y-auto p-4">
            {items.length === 0 ? (
              <div className="text-center text-gray-500 mt-8">
                Your cart is empty
              </div>
            ) : (
              <div className="space-y-4">
                {items.map((item) => (
                  <div
                    key={item.id}
                    className="flex gap-4 bg-white rounded-lg p-4 border"
                  >
                    {/* Item Image */}
                    <div className="relative w-20 h-20 rounded-md overflow-hidden flex-shrink-0">
                      <Image
                        src={item.image}
                        alt={item.name}
                        fill
                        className="object-cover"
                      />
                    </div>

                    {/* Item Details */}
                    <div className="flex-1">
                      <h3 className="font-medium">{item.name}</h3>
                      <p className="text-sm text-gray-600">
                        Size: {item.size || 'N/A'}
                      </p>
                      <div className="text-teal-600 font-medium mt-1">
                        ${item.price.toLocaleString()}
                      </div>
                    </div>

                    {/* Remove Button */}
                    <button
                      onClick={() => handleRemove(item.id)}
                      className="text-gray-400 hover:text-gray-600 disabled:opacity-50"
                      disabled={isRemoving === item.id}
                    >
                      {isRemoving === item.id ? (
                        <Loader2 className="w-5 h-5 animate-spin" />
                      ) : (
                        <X className="w-5 h-5" />
                      )}
                    </button>
                  </div>
                ))}
              </div>
            )}
          </div>

          {/* Footer with Total and Checkout */}
          {items.length > 0 && (
            <div className="border-t p-4 space-y-4">
              <div className="flex items-center justify-between">
                <span className="font-medium">Total</span>
                <span className="text-xl font-medium text-teal-600">
                  ${total.toLocaleString()}
                </span>
              </div>
              <button 
                onClick={() => setShowCheckout(true)}
                className="w-full bg-teal-600 text-white py-3 rounded-lg font-medium hover:bg-teal-700"
              >
                Proceed to Checkout
              </button>
            </div>
          )}
        </div>
      </div>

      {/* Checkout Simulation Modal */}
      {showCheckout && (
        <CheckoutSimulation
          onClose={() => setShowCheckout(false)}
          total={total}
        />
      )}
    </>
  );
} 
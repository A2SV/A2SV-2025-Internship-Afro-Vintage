'use client';

import React from 'react';
import { useState } from 'react';
import { useCart } from '@/context/CartContext';
import { Loader2 } from 'lucide-react';
import OrderConfirmation from './OrderConfirmation';

type CheckoutSimulationProps = {
  onClose: () => void;
  total: number;
};

export default function CheckoutSimulation({ onClose, total }: CheckoutSimulationProps) {
  const { checkout, items } = useCart();
  const [isProcessing, setIsProcessing] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [showConfirmation, setShowConfirmation] = useState(false);
  const [orderId, setOrderId] = useState<string | null>(null);

  const handleCheckout = async () => {
    setIsProcessing(true);
    setError(null);
    
    try {
      const result = await checkout();
      if (result.success) {
        setOrderId(result.data?.order_id || 'N/A');
        setShowConfirmation(true);
      } else {
        setError(result.message);
      }
    } catch (err) {
      setError('An unexpected error occurred during checkout');
    } finally {
      setIsProcessing(false);
    }
  };

  const platformFee = total * 0.02;
  const totalWithFee = total + platformFee;

  if (showConfirmation && orderId) {
    return (
      <OrderConfirmation
        orderId={orderId}
        items={items}
        total={totalWithFee}
        onClose={onClose}
      />
    );
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div className="bg-white rounded-lg p-6 w-96">
        <h2 className="text-xl font-medium mb-4">Simulated Checkout</h2>
        
        <div className="space-y-4">
          <div className="flex justify-between">
            <span>Subtotal:</span>
            <span>${total.toLocaleString()}</span>
          </div>
          <div className="flex justify-between text-gray-600">
            <span>Platform Fee (2%):</span>
            <span>${platformFee.toLocaleString()}</span>
          </div>
          <div className="border-t pt-2 flex justify-between font-medium">
            <span>Total:</span>
            <span>${totalWithFee.toLocaleString()}</span>
          </div>
        </div>

        {error && (
          <div className="mt-4 p-2 bg-red-50 text-red-600 rounded text-sm">
            {error}
          </div>
        )}

        <div className="mt-6 flex gap-3">
          <button
            onClick={onClose}
            className="flex-1 py-2 px-4 border rounded-lg hover:bg-gray-50"
            disabled={isProcessing}
          >
            Cancel
          </button>
          <button
            onClick={handleCheckout}
            className="flex-1 py-2 px-4 bg-teal-600 text-white rounded-lg hover:bg-teal-700 flex items-center justify-center"
            disabled={isProcessing}
          >
            {isProcessing ? (
              <>
                <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                Processing...
              </>
            ) : (
              'Confirm Payment'
            )}
          </button>
        </div>
      </div>
    </div>
  );
} 
'use client';

import React from 'react';
import { useRouter } from 'next/navigation';
import { CheckCircle2, Clock, ArrowLeft } from 'lucide-react';

type OrderConfirmationProps = {
  orderId: string;
  items: Array<{
    id: string;
    name: string;
    price: number;
  }>;
  total: number;
  onClose: () => void;
};

export default function OrderConfirmation({
  orderId,
  items,
  total,
  onClose,
}: OrderConfirmationProps) {
  const router = useRouter();

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div className="bg-white rounded-lg p-6 w-96">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-xl font-medium">Order Confirmation</h2>
          <button
            onClick={onClose}
            className="text-gray-400 hover:text-gray-600"
          >
            <ArrowLeft className="w-6 h-6" />
          </button>
        </div>

        <div className="space-y-4">
          <div className="flex items-center gap-2 text-teal-600">
            <CheckCircle2 className="w-5 h-5" />
            <span className="font-medium">Order Placed Successfully!</span>
          </div>

          <div className="border rounded-lg p-4">
            <div className="text-sm text-gray-600 mb-2">Order #{orderId}</div>
            <div className="space-y-2">
              {items.map((item) => (
                <div key={item.id} className="flex justify-between">
                  <span>{item.name}</span>
                  <span>${item.price.toLocaleString()}</span>
                </div>
              ))}
            </div>
            <div className="border-t mt-2 pt-2 flex justify-between font-medium">
              <span>Total</span>
              <span>${total.toLocaleString()}</span>
            </div>
          </div>

          <div className="flex items-center gap-2 text-amber-600">
            <Clock className="w-5 h-5" />
            <span>Status: Pending Delivery</span>
          </div>

          <div className="text-sm text-gray-600">
            Your items will appear in "My Orders" after a 3-minute delivery simulation.
          </div>

          <div className="flex gap-3 mt-6">
            <button
              onClick={() => router.push('/consumer/orders')}
              className="flex-1 py-2 px-4 bg-teal-600 text-white rounded-lg hover:bg-teal-700"
            >
              Track Delivery
            </button>
            <button
              onClick={() => router.push('/consumer/marketplace')}
              className="flex-1 py-2 px-4 border rounded-lg hover:bg-gray-50"
            >
              Return to Marketplace
            </button>
          </div>
        </div>
      </div>
    </div>
  );
} 
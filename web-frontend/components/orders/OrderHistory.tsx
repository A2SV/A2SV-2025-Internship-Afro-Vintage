'use client';

import React, { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { Package, Clock, CheckCircle2, XCircle, Star } from 'lucide-react';
import { formatDistanceToNow } from 'date-fns';
import ReviewForm from '../reviews/ReviewForm';

type OrderStatus = 'PENDING_DELIVERY' | 'DELIVERED' | 'FAILED';

interface Order {
  id: string;
  items: Array<{
    id: string;
    name: string;
    price: number;
    hasReview?: boolean;
  }>;
  total: number;
  status: OrderStatus;
  createdAt: string;
  estimatedDeliveryTime?: string;
}

export default function OrderHistory() {
  const [orders, setOrders] = useState<Order[]>([]);
  const [loading, setLoading] = useState(true);
  const [showReviewForm, setShowReviewForm] = useState(false);
  const [selectedItem, setSelectedItem] = useState<{ id: string; name: string } | null>(null);
  const router = useRouter();

  useEffect(() => {
    fetchOrders();
    // Set up polling for order status updates
    const interval = setInterval(fetchOrders, 30000); // Poll every 30 seconds
    return () => clearInterval(interval);
  }, []);

  const fetchOrders = async () => {
    try {
      const response = await fetch('/api/orders', {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('token')}`,
        },
      });

      if (!response.ok) {
        throw new Error('Failed to fetch orders');
      }

      const data = await response.json();
      setOrders(data);
    } catch (error) {
      console.error('Error fetching orders:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleReviewSubmit = async (rating: number, comment: string) => {
    if (!selectedItem) return;

    try {
      const response = await fetch('/api/reviews', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('token')}`,
        },
        body: JSON.stringify({
          itemId: selectedItem.id,
          rating,
          comment,
        }),
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.message || 'Failed to submit review');
      }

      // Refresh orders to update review status
      await fetchOrders();
    } catch (error) {
      throw error;
    }
  };

  const getStatusIcon = (status: OrderStatus) => {
    switch (status) {
      case 'PENDING_DELIVERY':
        return <Clock className="w-5 h-5 text-amber-600" />;
      case 'DELIVERED':
        return <CheckCircle2 className="w-5 h-5 text-teal-600" />;
      case 'FAILED':
        return <XCircle className="w-5 h-5 text-red-600" />;
      default:
        return <Package className="w-5 h-5 text-gray-600" />;
    }
  };

  const getStatusText = (order: Order) => {
    switch (order.status) {
      case 'PENDING_DELIVERY':
        const createdAt = new Date(order.createdAt);
        const deliveryTime = new Date(createdAt.getTime() + 3 * 60 * 1000); // 3 minutes from creation
        const timeLeft = formatDistanceToNow(deliveryTime, { addSuffix: true });
        return `Arriving ${timeLeft}`;
      case 'DELIVERED':
        return 'Delivered';
      case 'FAILED':
        return 'Delivery Failed';
      default:
        return 'Unknown Status';
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-teal-600"></div>
      </div>
    );
  }

  if (orders.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center min-h-[400px] text-gray-500">
        <Package className="w-12 h-12 mb-4" />
        <h3 className="text-lg font-medium">No orders yet</h3>
        <p className="text-sm">Your completed orders will appear here</p>
        <button
          onClick={() => router.push('/marketplace')}
          className="mt-4 px-4 py-2 bg-teal-600 text-white rounded-lg hover:bg-teal-700"
        >
          Start Shopping
        </button>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold">Order History</h1>
      
      <div className="space-y-4">
        {orders.map((order) => (
          <div
            key={order.id}
            className="bg-white rounded-lg shadow-sm border p-4"
          >
            <div className="flex items-center justify-between mb-4">
              <div className="flex items-center gap-2">
                {getStatusIcon(order.status)}
                <span className="font-medium">Order #{order.id}</span>
              </div>
              <div className="text-sm text-gray-500">
                {new Date(order.createdAt).toLocaleDateString()}
              </div>
            </div>

            <div className="space-y-2 mb-4">
              {order.items.map((item) => (
                <div key={item.id} className="flex justify-between items-center">
                  <span>{item.name}</span>
                  <div className="flex items-center gap-2">
                    <span>${item.price.toLocaleString()}</span>
                    {order.status === 'DELIVERED' && !item.hasReview && (
                      <button
                        onClick={() => {
                          setSelectedItem({ id: item.id, name: item.name });
                          setShowReviewForm(true);
                        }}
                        className="text-teal-600 hover:text-teal-700 flex items-center gap-1"
                      >
                        <Star className="w-4 h-4" />
                        <span className="text-sm">Review</span>
                      </button>
                    )}
                  </div>
                </div>
              ))}
            </div>

            <div className="border-t pt-3 flex items-center justify-between">
              <div className="flex items-center gap-2">
                <span className="text-sm font-medium">
                  {getStatusText(order)}
                </span>
              </div>
              <div className="text-right">
                <div className="text-sm text-gray-500">Total</div>
                <div className="font-medium">${order.total.toLocaleString()}</div>
              </div>
            </div>
          </div>
        ))}
      </div>

      {showReviewForm && selectedItem && (
        <ReviewForm
          itemId={selectedItem.id}
          itemName={selectedItem.name}
          onClose={() => {
            setShowReviewForm(false);
            setSelectedItem(null);
          }}
          onSubmit={handleReviewSubmit}
        />
      )}
    </div>
  );
} 
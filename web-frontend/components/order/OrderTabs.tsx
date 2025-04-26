"use client"

import { useEffect, useState } from 'react'
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Card } from "@/components/ui/card"
import { Package, CreditCard, Truck, MessageSquare, RotateCcw } from "lucide-react"
import { orderApi } from '@/lib/api/order'
import { Order, OrderStatus } from '@/types/order'
import { useCart } from '@/context/CartContext'

const orderStatuses = [
  {
    id: "to-pay",
    label: "To Pay",
    icon: CreditCard,
  },
  {
    id: "completed",
    label: "Completed",
    icon: Package,
    status: 'DELIVERED' as OrderStatus,
  },
  {
    id: "shipped",
    label: "Shipped",
    icon: Truck,
    status: 'SHIPPED' as OrderStatus,
  },
  {
    id: "delivered",
    label: "Delivered",
    icon: MessageSquare,
    status: 'DELIVERED' as OrderStatus,
  },
  {
    id: "failed",
    label: "Failed",
    icon: RotateCcw,
    status: 'FAILED' as OrderStatus,
  }
]

export default function OrderTabs() {
  const [orders, setOrders] = useState<Order[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [activeTab, setActiveTab] = useState('to-pay');
  const { items: cartItems, loading: cartLoading } = useCart();

  useEffect(() => {
    loadOrders();
  }, []);

  const loadOrders = async () => {
    try {
      setLoading(true);
      const data = await orderApi.getOrderHistory();
      console.log('Loaded orders:', data);
      setOrders(data);
      setError(null);
    } catch (err) {
      console.error('Error loading orders:', err);
      setError(err instanceof Error ? err.message : 'Failed to load orders');
      setOrders([]);
    } finally {
      setLoading(false);
    }
  };

  const getOrdersByStatus = (status: OrderStatus) => {
    return orders.filter(order => order.status === status);
  };

  // Tab click handler
  const handleTabClick = (id: string) => setActiveTab(id);

  // Tab counts
  const completedOrders = orders.filter(
    order => order.status?.toLowerCase() === 'completed'
  );
  const shippedOrders = getOrdersByStatus('SHIPPED');
  const deliveredOrders = getOrdersByStatus('DELIVERED');
  const failedOrders = getOrdersByStatus('FAILED');

  if (error) {
    return (
      <div className="text-center py-8">
        <h3 className="text-lg font-medium text-red-600">Error</h3>
        <p className="mt-1 text-sm text-gray-500">{error}</p>
      </div>
    );
  }

  return (
    <div className="w-full max-w-4xl mx-auto mt-8">
      <div className="bg-[#F6F8F9] rounded-xl px-4 py-3 flex gap-2 mb-8">
        {orderStatuses.map((status) => {
          let count = 0;
          if (status.id === 'to-pay') count = cartItems.length;
          else if (status.status === 'DELIVERED' && status.id === 'completed') count = completedOrders.length;
          else if (status.status === 'SHIPPED') count = shippedOrders.length;
          else if (status.status === 'DELIVERED' && status.id === 'delivered') count = deliveredOrders.length;
          else if (status.status === 'FAILED') count = failedOrders.length;
          return (
            <button
              key={status.id}
              className={`px-5 py-2 rounded-full font-medium transition-all text-sm flex-1
                ${activeTab === status.id ? 'bg-teal-600 text-white' : 'bg-white text-gray-700 border border-gray-200 hover:bg-teal-50'}
              `}
              onClick={() => handleTabClick(status.id)}
            >
              {status.label}
              {count > 0 && (
                <span className="ml-2 bg-teal-600 text-white rounded-full px-2 py-0.5 text-xs">{count}</span>
              )}
            </button>
          );
        })}
      </div>
      {/* Tab content */}
      {activeTab === 'to-pay' && (
        cartLoading ? (
          <div className="flex justify-center py-12">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-gray-900"></div>
          </div>
        ) : cartItems.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-12">
            <CreditCard className="mb-4 h-12 w-12 text-muted-foreground" />
            <h3 className="mb-2 text-xl font-medium">No Items to Pay</h3>
            <p className="text-muted-foreground">You don&apos;t have any items in your cart at the moment</p>
          </div>
        ) : (
          <div className="flex flex-col gap-6">
            {cartItems.map((item) => (
              <div
                key={item.id}
                className="bg-white rounded-2xl shadow p-6 flex flex-col gap-2 relative"
              >
                <div className="flex justify-between items-start mb-2">
                  <span className="text-gray-400 font-medium text-sm">Seller Name</span>
                  <span className="text-orange-500 font-semibold text-base">Pending Payment</span>
                </div>
                <div className="flex gap-4 items-center">
                  <div className="w-20 h-20 rounded-lg overflow-hidden bg-gray-100 flex-shrink-0">
                    <img
                      src={item.image || '/images/placeholder.png'}
                      alt={item.name || 'Product'}
                      className="w-full h-full object-cover"
                    />
                  </div>
                  <div className="flex-1">
                    <div className="font-semibold text-lg mb-1">{item.name}</div>
                    <div className="font-bold text-xl">${item.price?.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2})}</div>
                  </div>
                  <div className="flex flex-col gap-2 items-end">
                    <button className="bg-teal-600 text-white rounded-full px-4 py-2 font-medium text-sm">Pay now</button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )
      )}
      {activeTab === 'completed' && (
        loading ? (
          <div className="flex justify-center py-12">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-gray-900"></div>
          </div>
        ) : completedOrders.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-12">
            <Package className="mb-4 h-12 w-12 text-muted-foreground" />
            <h3 className="mb-2 text-xl font-medium">No Completed Orders</h3>
            <p className="text-muted-foreground">You don&apos;t have any completed orders at the moment</p>
          </div>
        ) : (
          <div className="flex flex-col gap-6">
            {completedOrders.map((order) => {
              return (
                <div
                  key={order.id}
                  className="bg-white rounded-2xl shadow p-6 flex flex-col gap-2 relative"
                >
                  <div className="flex justify-between items-start mb-2">
                    <span className="text-gray-400 font-medium text-sm">Seller Name</span>
                    <span className="text-green-600 font-semibold text-base">Completed Payment</span>
                  </div>
                  <div className="flex gap-4 items-center">
                    <div className="w-20 h-20 rounded-lg overflow-hidden bg-gray-100 flex-shrink-0">
                      <img
                        src={order.imageUrl || '/images/placeholder.png'}
                        alt={order.title || 'Product'}
                        className="w-full h-full object-cover"
                      />
                    </div>
                    <div className="flex-1">
                      <div className="font-semibold text-lg mb-1">{order.title || 'Product'}</div>
                      <div className="font-bold text-xl">${order.price?.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2})}</div>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        )
      )}
      {activeTab === 'shipped' && (
        loading ? (
          <div className="flex justify-center py-12">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-gray-900"></div>
          </div>
        ) : shippedOrders.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-12">
            <Truck className="mb-4 h-12 w-12 text-muted-foreground" />
            <h3 className="mb-2 text-xl font-medium">No Shipped Orders</h3>
            <p className="text-muted-foreground">You don&apos;t have any shipped orders at the moment</p>
          </div>
        ) : (
          <div className="flex flex-col gap-6">
            {shippedOrders.map((order) => {
              return (
                <div
                  key={order.id}
                  className="bg-white rounded-2xl shadow p-6 flex flex-col gap-2 relative"
                >
                  <div className="flex justify-between items-start mb-2">
                    <span className="text-gray-400 font-medium text-sm">Seller Name</span>
                    <span className="text-orange-500 font-semibold text-base">Shipped</span>
                  </div>
                  <div className="flex gap-4 items-center">
                    <div className="w-20 h-20 rounded-lg overflow-hidden bg-gray-100 flex-shrink-0">
                      <img
                        src={order.imageUrl || '/images/placeholder.png'}
                        alt={order.title || 'Product'}
                        className="w-full h-full object-cover"
                      />
                    </div>
                    <div className="flex-1">
                      <div className="font-semibold text-lg mb-1">{order.title || 'Product'}</div>
                      <div className="font-bold text-xl">${order.price?.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2})}</div>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        )
      )}
      {activeTab === 'delivered' && (
        loading ? (
          <div className="flex justify-center py-12">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-gray-900"></div>
          </div>
        ) : deliveredOrders.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-12">
            <MessageSquare className="mb-4 h-12 w-12 text-muted-foreground" />
            <h3 className="mb-2 text-xl font-medium">No Delivered Orders</h3>
            <p className="text-muted-foreground">You don&apos;t have any delivered orders at the moment</p>
          </div>
        ) : (
          <div className="flex flex-col gap-6">
            {deliveredOrders.map((order) => {
              return (
                <div
                  key={order.id}
                  className="bg-white rounded-2xl shadow p-6 flex flex-col gap-2 relative"
                >
                  <div className="flex justify-between items-start mb-2">
                    <span className="text-gray-400 font-medium text-sm">Seller Name</span>
                    <span className="text-orange-500 font-semibold text-base">Delivered</span>
                  </div>
                  <div className="flex gap-4 items-center">
                    <div className="w-20 h-20 rounded-lg overflow-hidden bg-gray-100 flex-shrink-0">
                      <img
                        src={order.imageUrl || '/images/placeholder.png'}
                        alt={order.title || 'Product'}
                        className="w-full h-full object-cover"
                      />
                    </div>
                    <div className="flex-1">
                      <div className="font-semibold text-lg mb-1">{order.title || 'Product'}</div>
                      <div className="font-bold text-xl">${order.price?.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2})}</div>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        )
      )}
      {activeTab === 'failed' && (
        loading ? (
          <div className="flex justify-center py-12">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-gray-900"></div>
          </div>
        ) : failedOrders.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-12">
            <RotateCcw className="mb-4 h-12 w-12 text-muted-foreground" />
            <h3 className="mb-2 text-xl font-medium">No Failed Orders</h3>
            <p className="text-muted-foreground">You don&apos;t have any failed orders at the moment</p>
          </div>
        ) : (
          <div className="flex flex-col gap-6">
            {failedOrders.map((order) => {
              return (
                <div
                  key={order.id}
                  className="bg-white rounded-2xl shadow p-6 flex flex-col gap-2 relative"
                >
                  <div className="flex justify-between items-start mb-2">
                    <span className="text-gray-400 font-medium text-sm">Seller Name</span>
                    <span className="text-orange-500 font-semibold text-base">Failed</span>
                  </div>
                  <div className="flex gap-4 items-center">
                    <div className="w-20 h-20 rounded-lg overflow-hidden bg-gray-100 flex-shrink-0">
                      <img
                        src={order.imageUrl || '/images/placeholder.png'}
                        alt={order.title || 'Product'}
                        className="w-full h-full object-cover"
                      />
                    </div>
                    <div className="flex-1">
                      <div className="font-semibold text-lg mb-1">{order.title || 'Product'}</div>
                      <div className="font-bold text-xl">${order.price?.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2})}</div>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        )
      )}
    </div>
  );
} 
"use client"

import { useEffect, useState } from 'react'
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Card } from "@/components/ui/card"
import { Package, CreditCard, Truck, MessageSquare, RotateCcw } from "lucide-react"
import { orderApi } from '@/lib/api/order'
import { Order, OrderStatus } from '@/types/order'
import { useCart } from '@/context/CartContext'
import CheckoutSimulation from '../cart/CheckoutSimulation'

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
]

export default function OrderTabs() {
  const [orders, setOrders] = useState<Order[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [activeTab, setActiveTab] = useState('to-pay');
  const { items: cartItems, loading: cartLoading } = useCart();
  const [showCheckout, setShowCheckout] = useState(false);
  const [isSidebarCollapsed, setIsSidebarCollapsed] = useState(false);

  useEffect(() => {
    loadOrders();
  }, []);

  // Listen for sidebar collapse state
  useEffect(() => {
    const handleSidebarCollapse = (e: CustomEvent) => {
      setIsSidebarCollapsed(e.detail.isCollapsed);
    };

    window.addEventListener('sidebar-collapse', handleSidebarCollapse as EventListener);
    return () => {
      window.removeEventListener('sidebar-collapse', handleSidebarCollapse as EventListener);
    };
  }, []);

  const loadOrders = async () => {
    try {
      setLoading(true);
      const data = await orderApi.getOrderHistory();
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
    <div className={`w-full mx-auto mt-4 md:mt-8 ${isSidebarCollapsed ? 'max-w-5xl' : 'max-w-4xl'}`}>
      <div className="bg-[#F6F8F9] rounded-xl px-2 md:px-4 py-2 md:py-3 flex flex-wrap gap-2 md:gap-4 mb-4 md:mb-8">
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
              className={`px-4 md:px-6 py-2 md:py-2.5 rounded-full font-medium transition-all text-sm flex items-center justify-center gap-2
                ${activeTab === status.id 
                  ? 'bg-teal-600 text-white shadow-sm' 
                  : 'bg-white text-gray-700 border border-gray-200 hover:bg-teal-50 hover:border-teal-200'}
              `}
              onClick={() => handleTabClick(status.id)}
            >
              <status.icon className="w-4 h-4" />
              {status.label}
              {count > 0 && (
                <span className="bg-teal-600 text-white rounded-full px-2 py-0.5 text-xs">{count}</span>
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
          <div className="flex flex-col gap-4 md:gap-6">
            {cartItems.map((item) => (
              <div
                key={item.id}
                className="bg-white rounded-2xl shadow p-4 md:p-6 flex flex-col gap-2 relative"
              >
                <div className="flex flex-col md:flex-row md:justify-between md:items-start gap-2 md:gap-0 mb-2">
                  <span className="text-gray-400 font-medium text-sm">{item.resellerName}</span>
                  <span className="text-orange-500 font-semibold text-base">Pending Payment</span>
                </div>
                <div className="flex flex-col md:flex-row gap-4 items-start md:items-center">
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
                  <div 
                    onClick={() => setShowCheckout(true)}
                    className="flex flex-col gap-2 items-end w-full md:w-auto"
                  >
                    <button className="w-full md:w-auto bg-teal-600 text-white rounded-full px-4 py-2 font-medium text-sm">Pay now</button>
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
          <div className="flex flex-col gap-4 md:gap-6">
            {completedOrders.map((order) => {
              return (
                <div
                  key={order.id}
                  className="bg-white rounded-2xl shadow p-4 md:p-6 flex flex-col gap-2 relative"
                >
                  <div className="flex flex-col md:flex-row md:justify-between md:items-start gap-2 md:gap-0 mb-2">
                    <span className="text-gray-400 font-medium text-sm">{order.resellerName}</span>
                    <span className="text-green-600 font-semibold text-base">Completed Payment</span>
                  </div>
                  <div className="flex flex-col md:flex-row gap-4 items-start md:items-center">
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
      {/* Checkout Simulation Modal */}
      {showCheckout && (
        <CheckoutSimulation
          onClose={() => setShowCheckout(false)}
          total={1}
          selectedItems={cartItems.map(item => item.id)}
        />
      )}
    </div>
  );
} 
"use client"

import { useEffect, useState } from 'react'
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Card } from "@/components/ui/card"
import { Package, CreditCard, Truck, MessageSquare, RotateCcw } from "lucide-react"
import { orderApi } from '@/lib/api/order'
import { Order, OrderStatus } from '@/types/order'

const orderStatuses = [
  {
    id: "completed",
    label: "Completed",
    icon: Package,
    status: 'completed' as OrderStatus,
  },
  {
    id: "shipped",
    label: "Shipped",
    icon: Truck,
    status: 'shipped' as OrderStatus,
  },
  {
    id: "delivered",
    label: "Delivered",
    icon: MessageSquare,
    status: 'delivered' as OrderStatus,
  },
  {
    id: "failed",
    label: "Failed",
    icon: RotateCcw,
    status: 'failed' as OrderStatus,
  }
]

export default function OrderTabs() {
  const [orders, setOrders] = useState<Order[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

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

  if (error) {
    return (
      <div className="text-center py-8">
        <h3 className="text-lg font-medium text-red-600">Error</h3>
        <p className="mt-1 text-sm text-gray-500">{error}</p>
      </div>
    );
  }

  return (
    <Tabs defaultValue="completed" className="w-full">
      <TabsList className="h-auto p-0 bg-transparent flex gap-4">
        {orderStatuses.map((status) => {
          const statusOrders = getOrdersByStatus(status.status);
          return (
            <TabsTrigger
              key={status.id}
              value={status.id}
              className="flex-1 flex flex-col items-center gap-2 py-4 px-2 data-[state=active]:bg-primary/5 rounded-lg border hover:bg-primary/5 transition-colors"
            >
              <div className="relative">
                <status.icon className="h-6 w-6" />
                {statusOrders.length > 0 && (
                  <span className="absolute -right-2 -top-2 flex h-4 w-4 items-center justify-center rounded-full bg-primary text-xs text-primary-foreground">
                    {statusOrders.length}
                  </span>
                )}
              </div>
              <span>{status.label}</span>
            </TabsTrigger>
          );
        })}
      </TabsList>

      {loading ? (
        <div className="flex justify-center py-12">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-gray-900"></div>
        </div>
      ) : (
        orderStatuses.map((status) => {
          const statusOrders = getOrdersByStatus(status.status);
          return (
            <TabsContent key={status.id} value={status.id} className="mt-6">
              <Card className="p-6">
                {statusOrders.length === 0 ? (
                  <div className="flex flex-col items-center justify-center py-12">
                    <status.icon className="mb-4 h-12 w-12 text-muted-foreground" />
                    <h3 className="mb-2 text-xl font-medium">No {status.label} Orders</h3>
                    <p className="text-muted-foreground">
                      You don&apos;t have any {status.label.toLowerCase()} orders at the moment
                    </p>
                  </div>
                ) : (
                  <div className="grid gap-4">
                    {statusOrders.map((order) => (
                      <div
                        key={order.id}
                        className="flex items-center justify-between p-4 border rounded-lg hover:bg-gray-50 transition-colors"
                      >
                        <div className="flex items-center gap-4">
                          <div className="w-16 h-16 bg-gray-100 rounded-md overflow-hidden">
                            <img
                              src={order.imageUrl}
                              alt={order.title}
                              className="w-full h-full object-cover"
                            />
                          </div>
                          <div>
                            <h4 className="font-medium text-lg mb-1">{order.title}</h4>
                            <div className="space-y-1">
                              <p className="text-sm text-muted-foreground">
                                ${order.price.toFixed(2)}
                              </p>
                              <p className="text-xs text-muted-foreground">
                                Ordered on {new Date(order.purchaseDate).toLocaleDateString()}
                              </p>
                            </div>
                          </div>
                        </div>
                        {order.estimatedDeliveryTime && (
                          <div className="text-right">
                            <p className="text-sm font-medium">Estimated Delivery</p>
                            <p className="text-sm text-muted-foreground">
                              {order.estimatedDeliveryTime}
                            </p>
                          </div>
                        )}
                      </div>
                    ))}
                  </div>
                )}
              </Card>
            </TabsContent>
          );
        })
      )}
    </Tabs>
  );
} 
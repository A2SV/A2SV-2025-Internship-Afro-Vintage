import { Metadata } from "next"
import OrderTabs from "@/components/order/OrderTabs"

export const metadata: Metadata = {
  title: "My Orders | Afro Vintage",
  description: "View and manage your orders",
}

export default function OrdersPage() {
  return (
    <div className="container py-8">
      <div className="flex flex-col gap-8">
        <div>
          <h1 className="text-3xl font-bold">My Orders</h1>
          <p className="text-muted-foreground">View and manage your orders</p>
        </div>
        <OrderTabs />
      </div>
    </div>
  )
} 
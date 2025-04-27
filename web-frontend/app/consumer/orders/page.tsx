import { Metadata } from "next"
import OrderTabs from "@/components/consumer/order/OrderTabs"

export const metadata: Metadata = {
  title: "My Orders | Afro Vintage",
  description: "View and manage your orders",
}

export default function OrdersPage() {
  return (
    <div className="container py-8">
      <div className="flex flex-col gap-8">
        <OrderTabs />
      </div>
    </div>
  )
} 
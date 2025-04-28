import { Metadata } from "next"
import OrderTabs from "@/components/consumer/order/OrderTabs"

export const metadata: Metadata = {
  title: "My Orders | Afro Vintage",
  description: "View and manage your orders",
}

export default function OrdersPage() {
  return (
    <div className="container px-4 md:px-8 py-4 md:py-8">
      <div className="flex flex-col gap-4 md:gap-8">
        <OrderTabs />
      </div>
    </div>
  )
} 
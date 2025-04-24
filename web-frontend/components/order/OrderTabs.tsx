"use client"

import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Card } from "@/components/ui/card"
import { cn } from "@/lib/utils"
import { Package, CreditCard, Truck, MessageSquare, RotateCcw } from "lucide-react"

const orderStatuses = [
  {
    id: "to-pay",
    label: "Pay",
    icon: CreditCard,
    count: 0,
  },
  {
    id: "to-ship",
    label: "Ship",
    icon: Package,
    count: 0,
  },
  {
    id: "to-receive",
    label: "Receive",
    icon: Truck,
    count: 0,
  },
  {
    id: "to-review",
    label: "Review",
    icon: MessageSquare,
    count: 0,
  },
  {
    id: "refund",
    label: "Refund",
    icon: RotateCcw,
    count: 0,
  },
]

export default function OrderTabs() {
  return (
    <Tabs defaultValue="to-pay" className="w-full">
      <TabsList className="h-auto p-0 bg-transparent flex gap-4">
        {orderStatuses.map((status) => (
          <TabsTrigger
            key={status.id}
            value={status.id}
            className="flex-1 flex flex-col items-center gap-2 py-4 px-2 data-[state=active]:bg-primary/5 rounded-lg border hover:bg-primary/5 transition-colors"
          >
            <div className="relative">
              <status.icon className="h-6 w-6" />
              {status.count > 0 && (
                <span className="absolute -right-2 -top-2 flex h-4 w-4 items-center justify-center rounded-full bg-primary text-xs text-primary-foreground">
                  {status.count}
                </span>
              )}
            </div>
            <span>{status.label}</span>
          </TabsTrigger>
        ))}
      </TabsList>
      {orderStatuses.map((status) => (
        <TabsContent key={status.id} value={status.id} className="mt-6">
          <Card className="p-6">
            <div className="flex flex-col items-center justify-center py-12">
              <status.icon className="mb-4 h-12 w-12 text-muted-foreground" />
              <h3 className="mb-2 text-xl font-medium">No Orders to {status.label}</h3>
              <p className="text-muted-foreground">
                You don&apos;t have any orders that need to be {status.label.toLowerCase()}
              </p>
            </div>
          </Card>
        </TabsContent>
      ))}
    </Tabs>
  )
} 
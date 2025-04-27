import Navbar from "@/components/common/Navbar"
import Sidebar from "@/components/common/Sidebar"

export default function OrdersLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <div className="relative min-h-screen">
      <Navbar />
      <div className="flex">
        <Sidebar />
        <main className="flex-1 pl-64 pt-16">{children}</main>
      </div>
    </div>
  )
} 
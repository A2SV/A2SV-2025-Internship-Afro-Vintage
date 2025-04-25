// app/layout.tsx

import Link from "next/link";
import Image from "next/image";
import {
  LayoutDashboard,
  Plus,
  ShoppingCart,
  Boxes,
  Star,
  Settings,
  LogOut,
  Bell,
} from "lucide-react";
import "../globals.css";

export const metadata = {
  title: "Afro Vintage",
  description: "Your App Description",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>
        <div className="flex min-h-screen bg-gray-100">
          {/* Sidebar */}
          <aside className="w-50 bg-white shadow-md px-2 py-3">
            <div className="flex justify-start mb-6">
              <Image
                src="/Afro vintage logo.png"
                alt="Afro Vintage"
                width={120}
                height={50}
              />
            </div>
            <nav className="space-y-2">
              <Link
                href="/supplier/dashboard"
                className="flex items-center gap-2 text-black hover:text-gray-700 text-xs"
              >
                <LayoutDashboard className="w-6 h-6" />
                Dashboard
              </Link>
              <Link
                href="/supplier/addbundles"
                className="flex items-center gap-2 text-black hover:text-gray-700 text-xs"
              >
                <Plus className="w-6 h-6" />
                Add Bundle
              </Link>
              <Link
                href="/supplier/supplierOrder"
                className="flex items-center gap-2 text-black hover:text-gray-700 text-xs"
              >
                <ShoppingCart className="w-6 h-6" />
                Orders
              </Link>
              <Link
                href="/supplier/SupplierviewBundles"
                className="flex items-center gap-2 text-black hover:text-gray-700 text-xs"
              >
                <Boxes className="w-6 h-6" />
                View Bundles
              </Link>
              <Link
                href="/supplier/review"
                className="flex items-center gap-2 text-black hover:text-gray-700 text-xs"
              >
                <Star className="w-6 h-6" />
                Reviews
              </Link>
              <Link
                href="#"
                className="flex items-center gap-2 text-black hover:text-gray-700 text-xs"
              >
                <Settings className="w-6 h-6" />
                Settings
              </Link>
              <Link
                href="/logout"
                className="flex items-center gap-2 text-black hover:text-gray-700 text-xs pt-5"
              >
                <LogOut className="w-6 h-6" />
                Logout
              </Link>
            </nav>
          </aside>

          {/* Main Content Area */}
          <div className="flex-1 flex flex-col">
            <header className="flex justify-between items-center px-3 py-2">
              <div className="w-1/4" />
              <div className="w-1/3 flex justify-center">
                <input
                  type="text"
                  placeholder="Search"
                  className="w-full max-w-xs px-2 py-1 text-sm rounded-md border 
                    border-[#BDB7B7] placeholder-[#BDB7B7] focus:outline-none 
                    focus:ring-2 focus:ring-[#005B80]"
                />
              </div>
              <div className="w-1/4 flex items-center justify-end gap-3">
                <Bell className="w-6 h-6 cursor-pointer text-[#005B80]" />
                <div className="flex items-center gap-2">
                  <div className="text-right">
                    <p className="font-semibold text-sm text-[#005B80]">
                      Jake Santiago
                    </p>
                    <p className="text-xs text-[#005B80]">Supplier</p>
                  </div>
                  <Image
                    src="/avatar.jpeg"
                    alt="User Avatar"
                    width={30}
                    height={30}
                    className="rounded-full object-cover"
                  />
                </div>
              </div>
            </header>

            <main className="flex-1 p-5 overflow-y-auto text-sm">
              {children}
            </main>
          </div>
        </div>
      </body>
    </html>
  );
}

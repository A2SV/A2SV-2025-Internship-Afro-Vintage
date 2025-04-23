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
import "./globals.css";

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
          {/* Expanded Sidebar */}
          <aside className="w-130 bg-white shadow-md px-4 py-6">
            <div className="flex justify-start mb-10">
              <Image
                src="/Afro vintage logo.png"
                alt="Afro Vintage"
                width={220}
                height={70}
              />
            </div>
            <nav className="space-y-4">
              <Link
                href="/dashboard"
                className="flex items-center gap-4 text-black hover:text-gray-700 text-3xl"
              >
                <LayoutDashboard className="w-12 h-12" />
                Dashboard
              </Link>
              <Link
                href="/addbundles"
                className="flex items-center gap-4 text-black hover:text-gray-700 text-3xl"
              >
                <Plus className="w-12 h-12" />
                Add Bundle
              </Link>
              <Link
                href="/supplierOrder"
                className="flex items-center gap-4 text-black hover:text-gray-700 text-3xl"
              >
                <ShoppingCart className="w-12 h-12" />
                Orders
              </Link>
              <Link
                href="/SupplierviewBundles"
                className="flex items-center gap-4 text-black hover:text-gray-700 text-3xl"
              >
                <Boxes className="w-12 h-12" />
                View Bundles
              </Link>
              <Link
                href="/review"
                className="flex items-center gap-4 text-black hover:text-gray-700 text-3xl"
              >
                <Star className="w-12 h-12" />
                Reviews
              </Link>
              <Link
                href="/settings"
                className="flex items-center gap-4 text-black hover:text-gray-700 text-3xl"
              >
                <Settings className="w-12 h-12" />
                Settings
              </Link>
              <Link
                href="/logout"
                className="flex items-center gap-4 text-black hover:text-gray-700 text-3xl pt-10"
              >
                <LogOut className="w-12 h-12" />
                Logout
              </Link>
            </nav>
          </aside>

          {/* Main Content Area */}
          <div className="flex-1 flex flex-col">
            <header className="flex justify-between items-center px-6 py-4">
              <div className="w-1/4" />
              <div className="w-1/3 flex justify-center">
                <input
                  type="text"
                  placeholder="Search"
                  className="w-full max-w-xs px-4 py-2 rounded-md border 
                   border-[#BDB7B7] placeholder-[#BDB7B7] focus:outline-none 
                   focus:ring-2 focus:ring-[#005B80] text-lg"
                />
              </div>
              <div className="w-1/4 flex items-center justify-end gap-6">
                <Bell className="w-14 h-14 cursor-pointer text-[#005B80]" />
                <div className="flex items-center gap-4">
                  <div className="text-right">
                    <p className="font-semibold text-3xl text-[#005B80]">
                      Jake Santiago
                    </p>
                    <p className="text-2xl text-[#005B80]">Supplier</p>
                  </div>
                  <Image
                    src="/avatar.jpeg"
                    alt="User Avatar"
                    width={48}
                    height={48}
                    className="rounded-full object-cover"
                  />
                </div>
              </div>
            </header>

            <main className="flex-1 p-8 overflow-y-auto text-xl">
              {children}
            </main>
          </div>
        </div>
      </body>
    </html>
  );
}

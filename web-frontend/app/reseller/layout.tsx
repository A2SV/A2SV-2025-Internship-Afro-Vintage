"use client";

import { useState, useEffect } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import Image from "next/image";
import {
  LayoutDashboard,
  ShoppingBag,
  ShoppingCart,
  Boxes,
  Package,
  Star,
  Settings,
  LogOut,
  Bell,
  ChevronLeft,
  Menu,
} from "lucide-react";
import "../globals.css";

interface User {
  id: string;
  username: string;
  email: string;
  role: string;
  name?: string;
  image_url?: string;
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  const [isCollapsed, setIsCollapsed] = useState(false);
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [user, setUser] = useState<User | null>(null);
  const pathname = usePathname();

  useEffect(() => {
    const storedUser = localStorage.getItem("user");
    if (storedUser) {
      setUser(JSON.parse(storedUser));
    }
  }, []);

  const consumerNavItems = [
    { name: "Dashboard", href: "/dashboard", icon: LayoutDashboard },
    { name: "Market place", href: "/consumer/marketplace", icon: ShoppingBag },
    { name: "Orders", href: "/consumer/orders", icon: ShoppingCart },
    { name: "Settings", href: "/settings", icon: Settings },
  ];

  const supplierNavItems = [
    { name: "Dashboard", href: "/supplier/dashboard", icon: LayoutDashboard },
    { name: "Add Bundle", href: "/supplier/addbundles", icon: ShoppingBag },
    { name: "Marketplace", href: "/supplier/marketplace", icon: Package },
    { name: "Orders", href: "/supplier/supplierOrder", icon: ShoppingCart },
    { name: "View Bundles", href: "/supplier/SupplierviewBundles", icon: Boxes },
    { name: "Reviews", href: "/supplier/review", icon: Star },
    { name: "Settings", href: "/supplier/settings", icon: Settings },
  ];

  const resellerNavItems = [
    { name: "Dashboard", href: "/reseller/dashboard", icon: LayoutDashboard },
    { name: "Marketplace", href: "/reseller/marketplace", icon: ShoppingBag },
    { name: "My Warehouse", href: "/reseller/warehouse", icon: Package },
    { name: "Orders", href: "/reseller/orders", icon: ShoppingCart },
    { name: "Settings", href: "/reseller/settings", icon: Settings },
  ];

  let navItems = [];

  if (user?.role === "supplier") {
    navItems = supplierNavItems;
  } else if (user?.role === "reseller") {
    navItems = resellerNavItems;
  } else {
    navItems = consumerNavItems;
  }

  const handleLogout = () => {
    localStorage.removeItem("token");
    localStorage.removeItem("user");
    window.location.href = "/";
  };

  return (
    <div className="flex min-h-screen bg-white">
      {/* Sidebar */}
      <aside
        className={`
          fixed inset-y-0 left-0 z-50 flex flex-col
          transform bg-white shadow-lg transition-transform duration-300
          ${sidebarOpen ? "translate-x-0" : "-translate-x-full"}
          md:static md:translate-x-0 md:w-64
          ${isCollapsed && "md:w-16"}
        `}
      >
        <div className="md:hidden flex justify-end p-2">
          <button
            onClick={() => setSidebarOpen(false)}
            className="p-1 rounded hover:bg-gray-100"
          >
            <ChevronLeft className="w-6 h-6 text-gray-700" />
          </button>
        </div>

        {/* Logo */}
        <div className="flex justify-center items-center h-16 border-b">
          <Image
            src="/Afro vintage logo.png"
            alt="Afro Vintage"
            width={isCollapsed ? 40 : 120}
            height={isCollapsed ? 40 : 40}
            className="transition-all duration-300"
          />
        </div>

        {/* Navigation */}
        <nav className="flex-1 px-2 py-4 space-y-1 overflow-y-auto">
          {navItems.map((item) => {
            const Icon = item.icon;
            const isActive = pathname === item.href;
            return (
              <Link
                key={item.href}
                href={item.href}
                className={`flex items-center gap-2 px-3 py-2 rounded-md text-sm font-medium ${
                  isActive ? "text-teal-600 bg-teal-50" : "text-gray-700 hover:bg-gray-100 hover:text-gray-900"
                } ${isCollapsed ? "justify-center" : "justify-start"}`}
              >
                <Icon className="w-5 h-5" />
                {!isCollapsed && <span>{item.name}</span>}
              </Link>
            );
          })}

          <button
            onClick={handleLogout}
            className={`flex items-center gap-2 px-3 py-2 w-full text-sm font-medium text-gray-700 hover:bg-gray-100 hover:text-gray-900 ${isCollapsed ? "justify-center" : "justify-start"}`}
          >
            <LogOut className="w-5 h-5" />
            {!isCollapsed && <span>Logout</span>}
          </button>
        </nav>
      </aside>

      {/* Mobile overlay */}
      {sidebarOpen && (
        <div
          className="fixed inset-0 z-40 bg-black bg-opacity-30 md:hidden"
          onClick={() => setSidebarOpen(false)}
        />
      )}

      {/* Main content */}
      <div className="flex flex-1 flex-col">
        <header className="flex items-center justify-between px-4 py-3 bg-white shadow-sm">
          <div className="flex items-center gap-3">
            <button
              onClick={() => setSidebarOpen(true)}
              className="md:hidden p-1 rounded-md hover:bg-gray-100"
            >
              <Menu className="w-6 h-6 text-gray-700" />
            </button>
            <input
              type="text"
              placeholder="Search"
              className="px-3 py-2 rounded-lg border border-gray-300 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
            />
          </div>

          <div className="flex items-center gap-4">
            <Bell className="w-6 h-6 text-gray-700 cursor-pointer" />
            <div className="flex items-center gap-2">
              <div className="hidden sm:block text-right">
                <p className="font-semibold text-gray-800 text-sm">{user?.name || user?.username || "Guest"}</p>
                <p className="text-xs text-gray-600">{user?.role || "loading..."}</p>
              </div>
              <Image
                src={user?.image_url || "/avatar.jpeg"}
                alt="User Avatar"
                width={40}
                height={40}
                className="rounded-full object-cover"
              />
            </div>
          </div>
        </header>

        {/* Children */}
        <main className="flex-1 overflow-y-auto p-4">{children}</main>
      </div>
    </div>
  );
}

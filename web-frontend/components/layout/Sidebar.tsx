"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import {
  LayoutDashboard,
  ShoppingBag,
  ShoppingCart,
  Package,
  Star,
  Settings,
  LogOut,
} from "lucide-react";
import Image from "next/image";

const Sidebar = () => {
  const [role, setRole] = useState<string | null>(null); // State to store role
  const pathname = usePathname();

  useEffect(() => {
    // This runs on the client side only
    const savedUser = localStorage.getItem("user");
    if (savedUser) {
      const user = JSON.parse(savedUser);
      setRole(user.role); // Access role from user object
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
    { name: "Marketplace", href: "marketplace", icon: Package }, 
    { name: "Orders", href: "/supplier/supplierOrder", icon: ShoppingCart },
    { name: "View Bundles", href: "/supplier/SupplierviewBundles", icon: Package },
    { name: "Reviews", href: "/supplier/review", icon: Star },
    { name: "Settings", href: "/supplier/settings", icon: Settings },
  ];
  

  const resellerNavItems = [
    { name: "Dashboard", href: "/reseller/dashboard", icon: LayoutDashboard },
    { name: "Marketplace", href: "/reseller/marketplace", icon: ShoppingBag }, // ✅
    { name: "My Warehouse", href: "/reseller/warehouse", icon: Package },      // ✅
    { name: "Orders", href: "/reseller/orders", icon: ShoppingCart },
  ];
  
  // Determine which nav items to display based on the role
  let navItems = [];

  if (role === "supplier") {
    navItems = supplierNavItems;
  } else if (role === "reseller") {
    navItems = resellerNavItems;
  } else {
    navItems = consumerNavItems; // Default for consumer
  }

  const handleLogout = () => {
    localStorage.removeItem("token");
    localStorage.removeItem("user");
    window.location.href = "/"; // Redirect to home page after logout
  };

  return (
    <div className="w-64 bg-white h-screen fixed left-0 top-0 border-r border-gray-200">
      <div className="p-6">
        <Image src="/images/logo.png" alt="Afro Vintage" width={120} height={40} className="mb-8" />
      </div>

      <nav className="px-4">
        <ul className="space-y-2">
          {navItems.map((item) => {
            const Icon = item.icon;
            const isActive = pathname === item.href;
            return (
              <li key={item.name}>
                <Link
                  href={item.href}
                  className={`flex items-center space-x-3 px-4 py-2.5 rounded-lg transition-colors ${
                    isActive ? "text-teal-600 bg-teal-50" : "text-gray-600 hover:bg-gray-50"
                  }`}
                >
                  <Icon className="h-5 w-5" />
                  <span>{item.name}</span>
                </Link>
              </li>
            );
          })}
        </ul>
      </nav>

      <div className="absolute bottom-8 left-0 right-0 px-4">
        <button
          onClick={handleLogout}
          className="flex items-center space-x-3 px-4 py-2.5 w-full text-gray-600 hover:bg-gray-50 rounded-lg transition-colors"
        >
          <LogOut className="h-5 w-5" />
          <span>Log out</span>
        </button>
      </div>
    </div>
  );
};

export default Sidebar;

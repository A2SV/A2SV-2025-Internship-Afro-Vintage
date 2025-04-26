// app/layout.tsx
"use client";

import Link from "next/link";
import Image from "next/image";
import { useState } from "react";
import {
  LayoutDashboard,
  Plus,
  ShoppingCart,
  Boxes,
  Star,
  Settings,
  LogOut,
  Bell,
  ChevronLeft,
  ChevronRight,
  Menu,
} from "lucide-react";
import "../globals.css";

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const [isCollapsed, setIsCollapsed] = useState(false);
  const [sidebarOpen, setSidebarOpen] = useState(false);

  return (
    <div className="flex min-h-screen bg-white">
      {/* Off-canvas Sidebar for mobile, static on md+ */}
      <aside
        className={`
    fixed inset-y-0 left-0 z-50 flex flex-col
    transform bg-white shadow-lg transition-transform duration-300
    ${sidebarOpen ? "translate-x-0" : "-translate-x-full"}
    md:static md:translate-x-0 md:w-48
    ${isCollapsed && "md:w-16"}
  `}
      >
        {/* Close button for mobile */}
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
            width={isCollapsed ? 40 : 80}
            height={isCollapsed ? 40 : 28}
            className="transition-all duration-300"
          />
        </div>

        {/* Navigation Links */}
        <nav className="flex-1 px-2 py-4 space-y-1 overflow-y-auto">
          {[
            {
              href: "./dashboard",
              icon: LayoutDashboard,
              text: "Dashboard",
            },
            { href: "./marketplace", icon: Boxes, text: "marketplace" },
            { href: "./orders", icon: ShoppingCart, text: "Orders" },
            { href: "./review", icon: Star, text: "Reviews" },
            { href: "/settings", icon: Settings, text: "Settings" },
          ].map((link) => (
            <Link
              key={link.href}
              href={link.href}
              className={`
          flex items-center gap-2 px-3 py-2 rounded-md text-sm font-medium
          text-gray-700 hover:bg-gray-100 hover:text-gray-900
          ${isCollapsed ? "justify-center" : "justify-start"}
        `}
            >
              <link.icon className="w-5 h-5" />
              {!isCollapsed && <span>{link.text}</span>}
            </Link>
          ))}

          <Link
            href="/logout"
            className={`
        flex items-center gap-2 px-3 py-2 rounded-md text-sm font-medium
        text-gray-700 hover:bg-gray-100 hover:text-gray-900
        ${isCollapsed ? "justify-center" : "justify-start"}
      `}
          >
            <LogOut className="w-5 h-5" />
            {!isCollapsed && <span>Logout</span>}
          </Link>
        </nav>
      </aside>

      {/* Overlay for mobile when sidebar open */}
      {sidebarOpen && (
        <div
          className="fixed inset-0 z-40 bg-black bg-opacity-30 md:hidden"
          onClick={() => setSidebarOpen(false)}
        />
      )}

      {/* Main Content */}
      <div className="flex flex-1 flex-col md:pl-0">
        {/* Header */}
        <header className="flex flex-wrap items-center justify-between bg-white px-4 py-3 md:px-6 md:py-4 gap-3">
          {/* Left: hamburger (mobile) + search */}
          <div className="flex items-center gap-3 flex-1 min-w-0">
            <button
              onClick={() => setSidebarOpen(true)}
              className="md:hidden p-1 rounded-md hover:bg-gray-100 shrink-0"
            >
              <Menu className="w-6 h-6 text-gray-700" />
            </button>

            <div className="flex-1">
              <input
                type="text"
                placeholder="Search"
                className="w-full px-3 py-2 rounded-lg border border-gray-300 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
              />
            </div>
          </div>

          {/* Right: notifications + profile */}
          <div className="flex items-center gap-4 shrink-0">
            <Bell className="w-6 h-6 text-gray-700 cursor-pointer" />

            <div className="flex items-center gap-2">
              <div className="text-right hidden sm:block leading-tight">
                <p className="font-semibold text-gray-800 text-sm">
                  Jake Santiago
                </p>
                <p className="text-xs text-gray-600">reseller</p>
              </div>

              <Image
                src="/avatar.jpeg"
                alt="User Avatar"
                width={40}
                height={40}
                className="rounded-full object-cover w-8 h-8 sm:w-10 sm:h-10"
              />
            </div>
          </div>
        </header>

        {/* Page Content */}
        <main className="flex-1 overflow-y-auto p-4 md:p-6">{children}</main>
      </div>
    </div>
  );
}

'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import {
  LayoutDashboard,
  ShoppingBag,
  ShoppingCart,
  Package,
  Star,
  Settings,
  LogOut
} from 'lucide-react';
import Image from 'next/image';

const Sidebar = () => {
  const pathname = usePathname();

  const navItems = [
    { name: 'Marketplace', href: '/consumer/marketplace', icon: ShoppingBag },
    { name: 'Orders', href: '/orders', icon: ShoppingCart },
    { name: 'Settings', href: '/settings', icon: Settings },
  ];

  return (
    <div className="w-64 bg-white h-screen fixed left-0 top-0 border-r border-gray-200">
      <div className="p-6">
        <Image
          src="/images/logo.png"
          alt="Afro Vintage"
          width={120}
          height={40}
          className="mb-8"
        />
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
                    isActive ? 'text-teal-600 bg-teal-50' : 'text-gray-600 hover:bg-gray-50'
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

      <div className="absolute bottom-0 left-0 right-0 p-4">
        <button 
          onClick={() => {
            localStorage.removeItem('token');
            localStorage.removeItem('user');
            window.location.href = '/login';
          }}
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
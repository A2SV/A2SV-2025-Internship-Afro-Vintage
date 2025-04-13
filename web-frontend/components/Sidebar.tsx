import React from 'react';
import Link from 'next/link';
import { useRouter } from 'next/router';
import Image from 'next/image';
import { useAuth } from '../contexts/AuthContext';
import { UserRole } from '../config/roles';

const Sidebar: React.FC = () => {
  const router = useRouter();
  const { logout, user } = useAuth();

  const menuItemsByRole = {
    [UserRole.SUPPLIER]: [
      {
        label: 'Dashboard',
        icon: '⌂',
        href: '/dashboard/supplier',
      },
      {
        label: 'Add Bundle',
        icon: '➕',
        href: '/add-bundle',
      },
      {
        label: 'My Bundles',
        icon: '📦',
        href: '/my-bundles',
      },
      {
        label: 'Orders',
        icon: '🛍️',
        href: '/orders',
      },
      {
        label: 'Reviews',
        icon: '⭐',
        href: '/reviews',
      },
      {
        label: 'Settings',
        icon: '⚙️',
        href: '/settings',
      },
    ],
    [UserRole.RESELLER]: [
      {
        label: 'Dashboard',
        icon: '⌂',
        href: '/dashboard/reseller',
      },
      {
        label: 'Marketplace',
        icon: '🏪',
        href: '/marketplace1',
      },
      {
        label: 'My Warehouse',
        icon: '�',
        href: '/my-warehouse',
      },
      {
        label: 'Orders',
        icon: '🛍️',
        href: '/orders',
      },
      {
        label: 'Reviews',
        icon: '⭐',
        href: '/reviews',
      },
      {
        label: 'Settings',
        icon: '⚙️',
        href: '/settings',
      },
    ],
    [UserRole.CONSUMER]: [
      {
        label: 'Dashboard',
        icon: '⌂',
        href: '/dashboard/consumer',
      },
      {
        label: 'Marketplace',
        icon: '🏪',
        href: '/marketplace2',
      },
      {
        label: 'My Orders',
        icon: '🛍️',
        href: '/my-orders',
      },
      {
        label: 'Cart',
        icon: '🛒',
        href: '/cart',
      },
      {
        label: 'Reviews',
        icon: '⭐',
        href: '/reviews',
      },
      {
        label: 'Settings',
        icon: '⚙️',
        href: '/settings',
      },
    ],
    [UserRole.ADMIN]: [
      {
        label: 'Dashboard',
        icon: '⌂',
        href: '/dashboard/admin',
      },
      {
        label: 'Users',
        icon: '👥',
        href: '/admin/users',
      },
      {
        label: 'Bundles',
        icon: '📦',
        href: '/admin/bundles',
      },
      {
        label: 'Orders',
        icon: '🛍️',
        href: '/admin/orders',
      },
      {
        label: 'Reviews',
        icon: '⭐',
        href: '/admin/reviews',
      },
      {
        label: 'Reports',
        icon: '📊',
        href: '/admin/reports',
      },
      {
        label: 'Settings',
        icon: '⚙️',
        href: '/admin/settings',
      },
    ],
  };

  const handleLogout = async () => {
    await logout();
    router.push('/login');
  };

  // If no user or role, show nothing or a loading state
  if (!user?.role) {
    return null;
  }

  const menuItems = menuItemsByRole[user.role];

  return (
    <div className="w-64 h-screen bg-white shadow-lg flex flex-col fixed left-0 top-0">
      {/* Logo Section */}
      <div className="p-6 border-b">
        <Link href={`/dashboard/${user.role.toLowerCase()}`} className="flex items-center gap-2">
          <div className="relative w-8 h-8">
            <Image
              src="/images/logo.png"
              alt="AfroVintage Logo"
              width={32}
              height={32}
            />
          </div>
          <span className="text-xl font-semibold text-brown-600">AfroVintage</span>
        </Link>
      </div>

      {/* Role Badge */}
      <div className="px-6 py-2 bg-gray-50">
        <span className="text-sm font-medium text-gray-600">
          {user.role.charAt(0).toUpperCase() + user.role.slice(1).toLowerCase()}
        </span>
      </div>

      {/* Navigation Menu */}
      <nav className="flex-1 py-6">
        <ul className="space-y-2">
          {menuItems.map((item) => {
            const isActive = router.pathname === item.href;
            return (
              <li key={item.href}>
                <Link
                  href={item.href}
                  className={`flex items-center gap-3 px-6 py-3 text-gray-600 hover:bg-gray-50 hover:text-brown-600 transition-colors ${
                    isActive ? 'bg-gray-50 text-brown-600 border-r-4 border-brown-600' : ''
                  }`}
                >
                  <span className="text-xl">{item.icon}</span>
                  <span className="text-sm font-medium">{item.label}</span>
                </Link>
              </li>
            );
          })}
        </ul>
      </nav>

      {/* Logout Button */}
      <div className="p-6 border-t">
        <button
          onClick={handleLogout}
          className="flex items-center gap-3 px-6 py-3 w-full text-gray-600 hover:bg-gray-50 hover:text-brown-600 transition-colors rounded-lg"
        >
          <span className="text-xl">↪</span>
          <span className="text-sm font-medium">Log out</span>
        </button>
      </div>
    </div>
  );
};

export default Sidebar; 
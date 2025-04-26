'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { LayoutDashboard, ShoppingBag, ShoppingCart, Package, Star, Settings, LogOut, ChevronLeft, ChevronRight, Menu } from 'lucide-react';
import Image from 'next/image';

const Sidebar = () => {
  const pathname = usePathname();
  const [isCollapsed, setIsCollapsed] = useState(false);
  const [isMobile, setIsMobile] = useState(false);
  const [isOpen, setIsOpen] = useState(false);
  const [role, setRole] = useState<string | null>(null);

  useEffect(() => {
    const savedUser = localStorage.getItem('user');
    if (savedUser) {
      const user = JSON.parse(savedUser);
      setRole(user.role); // Get role from localStorage
    }
  }, []);

  useEffect(() => {
    const checkMobile = () => {
      setIsMobile(window.innerWidth < 768);
      if (window.innerWidth < 768) {
        setIsCollapsed(true);
      }
    };

    checkMobile();
    window.addEventListener('resize', checkMobile);
    return () => window.removeEventListener('resize', checkMobile);
  }, []);

  useEffect(() => {
    const event = new CustomEvent('sidebar-collapse', {
      detail: { isCollapsed },
    });
    window.dispatchEvent(event);
  }, [isCollapsed]);

  const consumerNavItems = [
    { name: 'Dashboard', href: '/dashboard', icon: LayoutDashboard },
    { name: 'Marketplace', href: '/consumer/marketplace', icon: ShoppingBag },
    { name: 'Orders', href: '/consumer/orders', icon: ShoppingCart },
    { name: 'Settings', href: '/settings', icon: Settings },
  ];

  const supplierNavItems = [
    { name: 'Dashboard', href: '/supplier/dashboard', icon: LayoutDashboard },
    { name: 'Add Bundle', href: '/supplier/addbundles', icon: ShoppingBag },
    { name: 'Marketplace', href: '/supplier/marketplace', icon: Package },
    { name: 'Orders', href: '/supplier/supplierOrder', icon: ShoppingCart },
    { name: 'View Bundles', href: '/supplier/SupplierviewBundles', icon: Package },
    { name: 'Reviews', href: '/supplier/review', icon: Star },
    { name: 'Settings', href: '/supplier/settings', icon: Settings },
  ];

  const resellerNavItems = [
    { name: 'Dashboard', href: '/reseller/dashboard', icon: LayoutDashboard },
    { name: 'Warehouse', href: '/reseller/warehouse', icon: Package },
    { name: 'Marketplace', href: '/reseller/marketplace', icon: ShoppingBag },
    { name: 'Orders', href: '/reseller/orders', icon: ShoppingCart },
    { name: 'Settings', href: '/reseller/settings', icon: Settings },
  ];

  let navItems = [];

  if (role === 'supplier') {
    navItems = supplierNavItems;
  } else if (role === 'reseller') {
    navItems = resellerNavItems;
  } else {
    navItems = consumerNavItems;
  }

  const handleLogout = () => {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    window.location.href = '/login';
  };

  return (
    <>
      {/* Mobile Menu Button */}
      {isMobile && (
        <button
          onClick={() => setIsOpen(!isOpen)}
          className="fixed top-4 left-4 z-50 p-2 rounded-lg bg-white shadow-md md:hidden"
        >
          <Menu className="w-6 h-6" />
        </button>
      )}

      {/* Overlay for mobile */}
      {isMobile && isOpen && (
        <div
          className="fixed inset-0 bg-black bg-opacity-50 z-40 md:hidden"
          onClick={() => setIsOpen(false)}
        />
      )}

      {/* Sidebar */}
      <div
        className={`
          fixed top-0 left-0 h-screen bg-white border-r border-gray-200 z-30
          transition-all duration-300
          ${isMobile ? (isOpen ? 'translate-x-0' : '-translate-x-full') : 'translate-x-0'}
          ${isCollapsed ? 'w-20' : 'w-64'}
        `}
      >
        <div className="p-6 flex justify-between items-center">
          <Image
            src="/images/logo.png"
            alt="Afro Vintage"
            width={isCollapsed ? 40 : 120}
            height={isCollapsed ? 40 : 40}
            className="transition-all duration-300"
          />
          {!isMobile && (
            <button
              onClick={() => setIsCollapsed(!isCollapsed)}
              className="p-2 rounded-lg hover:bg-gray-100"
            >
              {isCollapsed ? <ChevronRight className="w-5 h-5" /> : <ChevronLeft className="w-5 h-5" />}
            </button>
          )}
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
                    onClick={() => isMobile && setIsOpen(false)}
                  >
                    <Icon className="h-5 w-5" />
                    {!isCollapsed && <span>{item.name}</span>}
                  </Link>
                </li>
              );
            })}
          </ul>
        </nav>

        <div className="absolute bottom-0 left-0 right-0 p-4">
          <button
            onClick={handleLogout}
            className="flex items-center space-x-3 px-4 py-2.5 w-full text-gray-600 hover:bg-gray-50 rounded-lg transition-colors"
          >
            <LogOut className="h-5 w-5" />
            {!isCollapsed && <span>Log out</span>}
          </button>
        </div>
      </div>
    </>
  );
};

export default Sidebar;

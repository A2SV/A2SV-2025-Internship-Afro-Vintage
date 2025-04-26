'use client';

import { ChevronDown, Filter, Menu } from 'lucide-react';
import Image from 'next/image';
import { useState, useEffect, useRef } from 'react';
import { useRouter } from 'next/navigation';
import { useCart } from '@/context/CartContext';
import CartView from '../consumer/cart/CartView';
import ProfileSettingsModal from '@/components/profile/ProfileSettingsModal';
import { toast } from 'react-hot-toast';

type NavbarProps = {
  onFilterClick?: () => void;
};

interface User {
  id: string;
  username: string;
  email: string;
  role: string;
  name?: string;
  image_url?: string;
}

const Navbar = ({ onFilterClick }: NavbarProps) => {
  const router = useRouter();
  const [user, setUser] = useState<User | null>(null);
  const [showProfileMenu, setShowProfileMenu] = useState(false);
  const [isCartOpen, setIsCartOpen] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');
  const [isSidebarCollapsed, setIsSidebarCollapsed] = useState(false);
  const [showProfileModal, setShowProfileModal] = useState(false);
  const { items } = useCart();
  const profileMenuRef = useRef<HTMLDivElement>(null);

  const fetchUserFromLocalStorage = () => {
    const userData = localStorage.getItem('user');
    if (userData) {
      setUser(JSON.parse(userData));
    }
  };

  useEffect(() => {
    fetchUserFromLocalStorage();
  }, []);

  useEffect(() => {
    const handleSidebarCollapse = (e: CustomEvent) => {
      setIsSidebarCollapsed(e.detail.isCollapsed);
    };

    window.addEventListener('sidebar-collapse', handleSidebarCollapse as EventListener);
    return () => {
      window.removeEventListener('sidebar-collapse', handleSidebarCollapse as EventListener);
    };
  }, []);

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (
        showProfileMenu &&
        profileMenuRef.current &&
        !profileMenuRef.current.contains(event.target as Node)
      ) {
        setShowProfileMenu(false);
      }
    };
    document.addEventListener('click', handleClickOutside);
    return () => document.removeEventListener('click', handleClickOutside);
  }, [showProfileMenu]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (searchQuery.trim()) {
      const marketplacePage = document.querySelector('[data-marketplace-page]');
      if (marketplacePage) {
        const event = new CustomEvent('marketplace-search', {
          detail: { searchTerm: searchQuery.trim() },
        });
        marketplacePage.dispatchEvent(event);
      }
    }
  };

  const handleSignOut = () => {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    toast.success('✅ Signed out successfully');
    router.push('/login');
  };

  const handleProfileModalClose = () => {
    setShowProfileModal(false);
    fetchUserFromLocalStorage();
  };

  return (
    <>
      <div className={`h-16 fixed top-0 right-0 bg-white border-b border-gray-200 z-10 transition-all duration-300 ${
        isSidebarCollapsed ? 'left-20' : 'left-64'
      }`}>
        <div className="h-full px-4 md:px-8 flex items-center justify-between">
          {/* Search Bar */}
          <div className={`flex-1 flex items-center ${isSidebarCollapsed ? 'max-w-2xl' : 'max-w-xl'}`}>
            <form onSubmit={handleSearch} className="relative flex-1">
              <div className="absolute inset-y-0 left-3 flex items-center pointer-events-none">
                <svg width="16" height="16" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M17.5 17.5L12.5 12.5M14.1667 8.33333C14.1667 11.555 11.555 14.1667 8.33333 14.1667C5.11167 14.1667 2.5 11.555 2.5 8.33333C2.5 5.11167 5.11167 2.5 8.33333 2.5C11.555 2.5 14.1667 5.11167 14.1667 8.33333Z" stroke="#6B7280" strokeWidth="1.66667" strokeLinecap="round" strokeLinejoin="round" />
                </svg>
              </div>
              <input
                type="text"
                placeholder="Search Bundles"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="w-full pl-10 pr-4 py-2 border border-gray-200 rounded-lg focus:outline-none focus:border-teal-500 text-sm"
              />
            </form>
            {onFilterClick && (
              <button
                onClick={onFilterClick}
                className="ml-2 p-2 border border-gray-200 rounded-lg hover:bg-gray-50"
              >
                <Filter className="w-5 h-5 text-gray-600" />
              </button>
            )}
          </div>

          {/* Right Section */}
          <div className="flex items-center space-x-4 md:space-x-6">
            {user?.role === 'consumer' && (
              <>
                {/* Cart Button */}
                <button
                  onClick={() => setIsCartOpen(true)}
                  className="p-2 text-teal-600 hover:bg-gray-50 rounded-lg relative"
                >
                  <svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                    <path fillRule="evenodd" clipRule="evenodd" d="M3 1C2.44772 1 2 1.44772 2 2C2 2.55228 2.44772 3 3 3H4.21922L5.89253 9.69321L4.99995 10.5858C3.74002 11.8457 4.63235 14 6.41416 14H15C16.1046 14 17 13.5523 17 13V14.0503C17 13.2674 16.6839 12.5123 16.1213 11.9497L15 10.8293V7C15 4.23858 12.7614 2 10 2Z" fill="currentColor" />
                  </svg>
                  {items.length > 0 && (
                    <span className="absolute -top-1 -right-1 bg-teal-600 text-white text-xs w-5 h-5 rounded-full flex items-center justify-center">
                      {items.length}
                    </span>
                  )}
                </button>
              </>
            )}

            {/* Profile Menu */}
            <div className="relative" ref={profileMenuRef}>
              <button
                onClick={() => setShowProfileMenu(!showProfileMenu)}
                className="flex items-center space-x-2 focus:outline-none"
              >
                <div className="w-8 h-8 rounded-full overflow-hidden bg-gray-200">
                  <Image
                    src={user?.image_url || '/images/avatar.png'}
                    alt={user?.username || 'Profile'}
                    width={32}
                    height={32}
                    className="object-cover"
                  />
                </div>
                <div className={`items-center ${isSidebarCollapsed ? 'hidden' : 'hidden md:flex'}`}>
                  <div>
                    <div className="text-sm font-semibold text-teal-600">
                      {user?.username || 'Guest'}
                    </div>
                    <div className="text-xs text-teal-600">
                      {user?.role || 'Loading...'}
                    </div>
                  </div>
                  <ChevronDown className="h-4 w-4 ml-2 text-gray-400" />
                </div>
              </button>

              {/* Profile Dropdown */}
              {showProfileMenu && (
                <div className="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg py-1 z-20 border border-gray-100">
                  <button
                    onClick={() => {
                      setShowProfileMenu(false);
                      router.push('/profile-settings');
                      setShowProfileModal(true);
                    }}
                    className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 w-full text-left"
                  >
                    Profile Settings
                  </button>
                  <button
                    onClick={handleSignOut}
                    className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 w-full text-left"
                  >
                    Sign Out
                  </button>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>

      {/* Cart Modal */}
      <CartView isOpen={isCartOpen} onClose={() => setIsCartOpen(false)} />

      {/* Profile Modal */}
      <ProfileSettingsModal
        isOpen={showProfileModal}
        onClose={handleProfileModalClose}
        user={user}
      />
    </>
  );
};

export default Navbar;

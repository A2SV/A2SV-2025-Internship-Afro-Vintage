'use client';

import { ChevronDown, Filter } from 'lucide-react';
import Image from 'next/image';
import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { useCart } from '@/context/CartContext';
import CartView from '../consumer/cart/CartView';

type NavbarProps = {
  onFilterClick?: () => void;
};

interface User {
  id: string;
  username: string;
  email: string;
  role: string;
}

const Navbar = ({ onFilterClick }: NavbarProps) => {
  const router = useRouter();
  const [user, setUser] = useState<User | null>(null);
  const [showProfileMenu, setShowProfileMenu] = useState(false);
  const [isCartOpen, setIsCartOpen] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const { items } = useCart();

  useEffect(() => {
    const userData = localStorage.getItem('user');
    if (userData) {
      setUser(JSON.parse(userData));
    }
  }, []);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (searchTerm.trim()) {
      // Update the marketplace page's filters directly
      const marketplacePage = document.querySelector('[data-marketplace-page]');
      if (marketplacePage) {
        const event = new CustomEvent('marketplace-search', {
          detail: { searchTerm: searchTerm.trim() }
        });
        marketplacePage.dispatchEvent(event);
      }
    }
  };

  const handleSignOut = () => {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    router.push('/login');
  };

  return (
    <>
      <div className="h-16 fixed top-0 right-0 left-64 bg-white border-b border-gray-200 z-10">
        <div className="h-full px-8 flex items-center justify-between">
          {/* Search */}
          <div className="flex-1 max-w-xl flex items-center">
            <form onSubmit={handleSearch} className="relative flex-1">
              <div className="absolute inset-y-0 left-3 flex items-center pointer-events-none">
                <svg width="16" height="16" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M17.5 17.5L12.5 12.5M14.1667 8.33333C14.1667 11.555 11.555 14.1667 8.33333 14.1667C5.11167 14.1667 2.5 11.555 2.5 8.33333C2.5 5.11167 5.11167 2.5 8.33333 2.5C11.555 2.5 14.1667 5.11167 14.1667 8.33333Z" stroke="#6B7280" strokeWidth="1.66667" strokeLinecap="round" strokeLinejoin="round"/>
                </svg>
              </div>
              <input
                type="text"
                placeholder="Search Bundles"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
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

          {/* Right section */}
          <div className="flex items-center space-x-6">
            <button className="p-2 text-teal-600 hover:bg-gray-50 rounded-lg">
              <svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                <path fillRule="evenodd" clipRule="evenodd" d="M10 2C7.23858 2 5 4.23858 5 7V10.8293L3.87868 11.9497C3.31607 12.5123 3 13.2674 3 14.0503V15C3 16.1046 3.89543 17 5 17H15C16.1046 17 17 16.1046 17 15V14.0503C17 13.2674 16.6839 12.5123 16.1213 11.9497L15 10.8293V7C15 4.23858 12.7614 2 10 2ZM8 18C8 19.1046 8.89543 20 10 20C11.1046 20 12 19.1046 12 18H8Z" fill="currentColor"/>
              </svg>
            </button>
            <button 
              onClick={() => setIsCartOpen(true)}
              className="p-2 text-teal-600 hover:bg-gray-50 rounded-lg relative"
            >
              <svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                <path fillRule="evenodd" clipRule="evenodd" d="M3 1C2.44772 1 2 1.44772 2 2C2 2.55228 2.44772 3 3 3H4.21922L4.52478 4.22224C4.52799 4.23637 4.5315 4.25039 4.5353 4.26429L5.89253 9.69321L4.99995 10.5858C3.74002 11.8457 4.63235 14 6.41416 14H15C15.5523 14 16 13.5523 16 13C16 12.4477 15.5523 12 15 12H6.41417L7.41417 11H14C14.3788 11 14.725 10.786 14.8944 10.4472L17.8944 4.44721C18.0494 4.13723 18.0329 3.76909 17.8507 3.47427C17.6684 3.17945 17.3466 3 17 3H6.28078L5.97014 1.75746C5.85885 1.3123 5.45887 1 5 1H3ZM7 18C7 19.1046 7.89543 20 9 20C10.1046 20 11 19.1046 11 18C11 16.8954 10.1046 16 9 16C7.89543 16 7 16.8954 7 18ZM13 20C11.8954 20 11 19.1046 11 18C11 16.8954 11.8954 16 13 16C14.1046 16 15 16.8954 15 18C15 19.1046 14.1046 20 13 20Z" fill="currentColor"/>
              </svg>
              {items.length > 0 && (
                <span className="absolute -top-1 -right-1 bg-teal-600 text-white text-xs w-5 h-5 rounded-full flex items-center justify-center">
                  {items.length}
                </span>
              )}
            </button>
            <div className="relative">
              <button 
                onClick={() => setShowProfileMenu(!showProfileMenu)}
                className="flex items-center space-x-3 focus:outline-none"
              >
                <div className="w-8 h-8 rounded-full overflow-hidden bg-gray-200">
                  <Image
                    src="/images/default-avatar.png"
                    alt="Profile"
                    width={32}
                    height={32}
                    className="object-cover"
                  />
                </div>
                <div className="flex items-center">
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

              {/* Profile Dropdown Menu */}
              {showProfileMenu && (
                <div className="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg py-1 z-20 border border-gray-100">
                  <button
                    onClick={() => {
                      setShowProfileMenu(false);
                      router.push('/profile-settings');
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
      <CartView isOpen={isCartOpen} onClose={() => setIsCartOpen(false)} />
    </>
  );
};

export default Navbar; 
import React from 'react';
import { UserRole } from '../config/roles';
import { BellIcon, MagnifyingGlassIcon } from '@heroicons/react/24/outline';
import Image from 'next/image';

interface NavbarProps {
  user: {
    name: string;
    role: UserRole;
    avatar?: string;
  };
  onSearch?: (query: string) => void;
}

const Navbar: React.FC<NavbarProps> = ({ user, onSearch }) => {
  const handleSearch = (e: React.ChangeEvent<HTMLInputElement>) => {
    onSearch?.(e.target.value);
  };

  return (
    <nav className="bg-white border-b border-gray-200">
      <div className="px-6 py-4">
        <div className="flex items-center justify-between">
          {/* Search Bar */}
          <div className="flex-1 max-w-lg">
            <div className="relative">
              <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <MagnifyingGlassIcon className="h-5 w-5 text-gray-400" />
              </div>
              <input
                type="search"
                placeholder="Search Bundles"
                className="block w-full pl-10 pr-3 py-2 border border-gray-200 rounded-lg 
                         focus:outline-none focus:ring-2 focus:ring-brown-500 focus:border-transparent
                         placeholder-gray-400 text-sm"
                onChange={handleSearch}
              />
            </div>
          </div>

          {/* Right Section */}
          <div className="flex items-center space-x-6">
            {/* Notifications */}
            <button className="relative text-gray-600 hover:text-gray-800 transition-colors">
              <BellIcon className="h-6 w-6" />
              <span className="absolute -top-1 -right-1 h-4 w-4 bg-red-500 rounded-full flex items-center justify-center">
                <span className="text-white text-xs">3</span>
              </span>
            </button>

            {/* User Profile */}
            <div className="flex items-center space-x-3">
              <div className="text-right">
                <h3 className="text-sm font-medium text-gray-900">{user.name}</h3>
                <p className="text-xs text-gray-500">{user.role}</p>
              </div>
              <div className="h-10 w-10 rounded-full overflow-hidden bg-gray-200">
                {user.avatar ? (
                  <Image
                    src={user.avatar}
                    alt={user.name}
                    width={40}
                    height={40}
                    className="h-full w-full object-cover"
                  />
                ) : (
                  <div className="h-full w-full flex items-center justify-center bg-brown-100 text-brown-800 text-lg font-medium">
                    {user.name.charAt(0)}
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>
    </nav>
  );
};

export default Navbar; 
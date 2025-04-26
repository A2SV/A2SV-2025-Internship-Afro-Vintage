'use client';

import React from 'react';
import { useState } from 'react';
import Sidebar from './Sidebar';
import Navbar from './Navbar';

export default function ClientLayout({ children }: { children: React.ReactNode }) {
  const [isFilterOpen, setIsFilterOpen] = useState(false);

  return (
    <div className="flex h-screen bg-gray-100 overflow-hidden">
      {/* Sidebar */}
      <Sidebar />

      {/* Main content area */}
      <div className="flex-1 flex flex-col overflow-hidden">
        {/* Navbar */}
        <Navbar onFilterClick={() => setIsFilterOpen(!isFilterOpen)} />

        {/* Content */}
        <main className="flex-1 overflow-y-auto bg-gray-50 px-8 py-6 mt-16 ml-64">
          <div className="max-w-7xl mx-auto">{children}</div>
        </main>
      </div>
    </div>
  );
}

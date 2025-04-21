'use client';

import { Item } from '@/types/marketplace';
import Image from 'next/image';

interface ItemGridProps {
  items: Item[];
  onItemClick: (item: Item) => void;
  onAddToCart: (item: Item) => void;
}

export default function ItemGrid({ items, onItemClick, onAddToCart }: ItemGridProps) {
  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 p-6">
      {items.map((item) => (
        <div
          key={item.id}
          className="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow duration-300"
        >
          <div className="relative h-48 cursor-pointer" onClick={() => onItemClick(item)}>
            <Image
              src={item.image}
              alt={item.name}
              fill
              className="object-cover"
            />
          </div>
          <div className="p-4">
            <h3 className="text-lg font-semibold text-gray-800 mb-2">{item.name}</h3>
            <p className="text-gray-600 text-sm mb-2">{item.category}</p>
            <div className="flex justify-between items-center">
              <span className="text-teal-600 font-bold">${item.price.toFixed(2)}</span>
              <button
                onClick={() => onAddToCart(item)}
                className="bg-teal-600 text-white px-4 py-2 rounded-md hover:bg-teal-700 transition-colors duration-300"
              >
                Add to Cart
              </button>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
} 
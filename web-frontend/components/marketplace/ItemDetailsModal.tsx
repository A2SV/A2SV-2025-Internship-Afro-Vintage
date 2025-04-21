'use client';

import { useState } from 'react';
import Image from 'next/image';
import { Star, X } from 'lucide-react';
import { Item } from '@/types/marketplace';

type ItemDetailsModalProps = {
  item: Item;
  onClose: () => void;
  isOpen: boolean;
};

export default function ItemDetailsModal({ item, onClose, isOpen }: ItemDetailsModalProps) {
  const [selectedSize, setSelectedSize] = useState('S');
  const sizes = ['S', 'M', 'L', 'XL'];

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div className="bg-white rounded-lg max-w-4xl w-full mx-4 relative">
        <button 
          onClick={onClose}
          className="absolute right-4 top-4 text-gray-400 hover:text-gray-600"
        >
          <X className="w-6 h-6" />
        </button>

        <div className="flex">
          {/* Left side - Image */}
          <div className="w-1/2">
            <div className="aspect-square relative">
              <Image
                src={item.image}
                alt={item.name}
                fill
                className="object-cover"
              />
            </div>
          </div>

          {/* Right side - Details */}
          <div className="w-1/2 p-8">
            <h1 className="text-2xl font-semibold text-gray-900 mb-4">{item.name}</h1>
            
            {/* Seller info */}
            <div className="flex items-center gap-3 mb-6">
              <div className="w-10 h-10 relative rounded-full overflow-hidden">
                <Image
                  src="/images/avatar.png"
                  alt="Jake Santiago"
                  fill
                  className="object-cover"
                />
              </div>
              <div>
                <h3 className="font-medium text-teal-600">Jake Santiago</h3>
                <div className="flex items-center gap-1">
                  <div className="flex">
                    {[1, 2, 3, 4, 5].map((star) => (
                      <Star 
                        key={star} 
                        className="w-4 h-4 fill-yellow-400 text-yellow-400" 
                      />
                    ))}
                  </div>
                  <span className="text-sm text-gray-600">
                    4.9 (2130 reviews)
                  </span>
                </div>
              </div>
            </div>

            {/* Description */}
            <div className="mb-6">
              <h3 className="text-sm font-medium text-gray-900 mb-2">Description:</h3>
              <ul className="text-sm text-gray-600 space-y-1">
                <li>• Makanan yang lengkap dan seimbang, dengan di nutrisi penting</li>
                <li>• Mengandung antioksidan (vitamin E dan selenium) untuk sistem kekebalan tubuh yang sehat</li>
                <li>• Mengandung serat untuk memperlancar pencernaan dan meningkatkan kesehatan usus</li>
              </ul>
            </div>

            {/* Size */}
            <div className="mb-6">
              <h3 className="text-sm font-medium text-gray-900 mb-2">Size</h3>
              <div className="flex gap-2">
                {sizes.map((size) => (
                  <button
                    key={size}
                    onClick={() => setSelectedSize(size)}
                    className={`w-12 h-12 rounded-lg border ${
                      selectedSize === size
                        ? 'border-teal-600 bg-teal-600 text-white'
                        : 'border-gray-200 text-gray-900 hover:border-teal-600'
                    }`}
                  >
                    {size}
                  </button>
                ))}
              </div>
            </div>

            {/* Price and Add to Cart */}
            <div className="flex items-center justify-between">
              <div>
                <span className="text-sm text-gray-500">Price</span>
                <div className="text-2xl font-semibold text-gray-900">
                  ${item.price.toLocaleString()}
                </div>
              </div>
              {item.status === 'available' ? (
                <button
                  className="px-8 py-3 bg-teal-600 text-white rounded-lg hover:bg-teal-700 transition-colors"
                  onClick={() => {
                    // Add to cart logic
                    onClose();
                  }}
                >
                  Add to Cart
                </button>
              ) : (
                <div className="px-8 py-3 bg-gray-100 text-gray-500 rounded-lg">
                  Item No Longer Available
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
} 
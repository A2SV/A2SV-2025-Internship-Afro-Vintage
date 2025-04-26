'use client';

import React from 'react';
import Image from 'next/image';
import { useResellerRatings } from '@/hooks/useResellerRatings';
import ResellerRating from '../reviews/ResellerRating';
import { ItemPreview } from '@/types/marketplace';

interface ItemCardProps {
  item: ItemPreview;
  onItemClick?: (item: ItemPreview) => void;
}

export default function ItemCard({ item, onItemClick }: ItemCardProps) {
  const { ratings, loading } = useResellerRatings(item.resellerId);

  const handleClick = () => {
    if (onItemClick) {
      onItemClick(item);
    }
  };

  return (
    <div 
      className="group relative bg-white rounded-lg overflow-hidden cursor-pointer hover:shadow-lg transition-shadow"
      onClick={handleClick}
    >
      <div className="relative h-64 w-full">
        <Image
          src={item.thumbnailUrl}
          alt={item.title}
          fill
          className="object-cover"
          unoptimized
          priority
        />
        <button 
          className="absolute top-4 right-4 bg-white p-2 rounded-full shadow-md hover:bg-gray-100"
          aria-label="Add to cart"
        >
          <svg 
            className="w-5 h-5 text-gray-600" 
            fill="none" 
            strokeWidth="2" 
            stroke="currentColor" 
            viewBox="0 0 24 24"
          >
            <path strokeLinecap="round" strokeLinejoin="round" d="M2.25 3h1.386c.51 0 .955.343 1.087.835l.383 1.437M7.5 14.25a3 3 0 00-3 3h15.75m-12.75-3h11.218c1.121-2.3 2.1-4.684 2.924-7.138a60.114 60.114 0 00-16.536-1.84M7.5 14.25L5.106 5.272M6 20.25a.75.75 0 11-1.5 0 .75.75 0 011.5 0zm12.75 0a.75.75 0 11-1.5 0 .75.75 0 011.5 0z" />
          </svg>
        </button>
      </div>
      
      <div className="p-4">
        <h3 className="text-lg font-medium text-gray-900 mb-2">{item.title}</h3>
        <div className="flex justify-between items-center">
          <span className="text-lg font-semibold text-gray-900">${item.price}</span>
          {!loading && ratings && (
            <ResellerRating
              resellerId={item.resellerId}
              resellerName={item.resellerName}
              averageRating={ratings.averageRating}
              reviewCount={ratings.reviewCount}
              reviews={ratings.reviews}
            />
          )}
        </div>
      </div>
    </div>
  );
} 
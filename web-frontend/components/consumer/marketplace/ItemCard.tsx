'use client';

import React from 'react';
import Image from 'next/image';
import { useResellerRatings } from '@/hooks/useResellerRatings';
import ResellerRating from '../reviews/ResellerRating';
import { ItemPreview } from '@/types/marketplace';
import { convertRatingToFiveScale } from '@/lib/utils/rating';
import { useCart } from '@/context/CartContext';

interface ItemCardProps {
  item: ItemPreview;
  onItemClick?: (item: ItemPreview) => void;
}

export default function ItemCard({ item, onItemClick }: ItemCardProps) {
  const { ratings, loading } = useResellerRatings(item.resellerId);
  const { isInCart } = useCart();

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
            className={`w-5 h-5 ${isInCart(item.id) ? 'text-teal-600 fill-teal-600' : 'text-gray-600'}`}
            fill={isInCart(item.id) ? 'currentColor' : 'none'}
            strokeWidth="2" 
            stroke="currentColor" 
            viewBox="0 0 24 24"
          >
            <path strokeLinecap="round" strokeLinejoin="round" d="M2.25 3h1.386c.51 0 .955.343 1.087.835l.383 1.437M7.5 14.25a3 3 0 00-3 3h15.75m-12.75-3h11.218c1.121-2.3 2.1-4.684 2.924-7.138a60.114 60.114 0 00-16.536-1.84M7.5 14.25L5.106 5.272M6 20.25a.75.75 0 11-1.5 0 .75.75 0 011.5 0zm12.75 0a.75.75 0 11-1.5 0 .75.75 0 011.5 0z" />
          </svg>
        </button>
      </div>
      
      <div className="p-4">
        <h3 className="text-xl font-bold text-gray-900 mb-4 px-2">{item.title}</h3>
        <div className="flex flex-row items-center justify-between px-2">
          <span className="text-lg font-semibold text-gray-900">${item.price}</span>
          <span className="flex items-center text-amber-500 font-medium text-base">
            <svg className="w-5 h-5 mr-1" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.286 3.967a1 1 0 00.95.69h4.178c.969 0 1.371 1.24.588 1.81l-3.385 2.46a1 1 0 00-.364 1.118l1.287 3.966c.3.922-.755 1.688-1.54 1.118l-3.385-2.46a1 1 0 00-1.175 0l-3.385 2.46c-.784.57-1.838-.196-1.54-1.118l1.287-3.966a1 1 0 00-.364-1.118l-3.385-2.46c-.783-.57-.38-1.81.588-1.81h4.178a1 1 0 00.95-.69l1.286-3.967z"/></svg>
            {item.rating ? convertRatingToFiveScale(item.rating).toFixed(1) : 'N/A'}
          </span>
        </div>
      </div>
    </div>
  );
} 
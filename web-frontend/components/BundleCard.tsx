import React from 'react';
import Image from 'next/image';
import Link from 'next/link';
import { Bundle } from '../types/bundle';
import { calculateStarRating } from '../config/trustThresholds';

interface BundleCardProps {
  bundle: Bundle;
  totalSold?: number;
  sortingType: 'sorted' | 'semi-sorted' | 'unsorted';
  grade: number;
  itemCount: number;
}

const sortingTypeColors = {
  'sorted': 'bg-green-600',
  'semi-sorted': 'bg-yellow-600',
  'unsorted': 'bg-gray-600'
};

const getGradeLabel = (grade: number) => {
  if (grade >= 90) return 'A';
  if (grade >= 80) return 'B';
  if (grade >= 70) return 'C';
  if (grade >= 60) return 'D';
  return 'F';
};

const BundleCard: React.FC<BundleCardProps> = ({ 
  bundle, 
  totalSold = 0,
  sortingType,
  grade,
  itemCount
}) => {
  const {
    id,
    title,
    price,
    images,
    supplier,
  } = bundle;

  const rating = supplier?.trustScore ? calculateStarRating(supplier.trustScore) : 0;

  return (
    <Link href={`/bundles/${id}`}>
      <div className="bg-white rounded-lg shadow-md overflow-hidden transition-transform hover:scale-105">
        {/* Quantity Badge */}
        <div className="absolute top-4 left-4 bg-brown-600 text-white rounded-full p-2 z-10">
          <span className="text-lg font-bold">100X</span>
        </div>

        {/* Sorting Type Badge */}
        <div className={`absolute top-4 right-4 ${sortingTypeColors[sortingType]} text-white rounded-full px-3 py-1 z-10 text-sm font-medium`}>
          {sortingType.charAt(0).toUpperCase() + sortingType.slice(1)}
        </div>

        {/* Image Container */}
        <div className="relative w-full h-64">
          <Image
            src={images[0] || '/placeholder.jpg'}
            alt={title}
            fill
            className="object-cover"
            sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
          />
        </div>

        {/* Content */}
        <div className="p-4">
          <div className="flex justify-between items-start mb-2">
            <h3 className="text-xl font-semibold truncate flex-1 mr-2">{title}</h3>
            <span className="text-sm font-medium px-2 py-1 bg-blue-100 text-blue-800 rounded">
              Grade {getGradeLabel(grade)}
            </span>
          </div>

          {/* Supplier and Item Count */}
          <div className="mb-3 text-sm text-gray-600">
            <div className="flex items-center mb-1">
              <span className="text-primary mr-2">👤</span>
              <span>{supplier?.businessName || 'Unknown Supplier'}</span>
            </div>
            <div className="flex items-center">
              <span className="text-primary mr-2">📦</span>
              <span>{itemCount} items</span>
            </div>
          </div>
          
          <div className="flex justify-between items-center mb-2">
            <span className="text-2xl font-bold text-primary">
              ${price.toFixed(2)}
            </span>
          </div>

          {/* Rating and Sales */}
          <div className="flex items-center justify-between text-sm text-gray-600">
            <div className="flex items-center">
              <span className="text-yellow-400 mr-1">★</span>
              <span>{rating.toFixed(1)}</span>
            </div>
            <span>{totalSold.toLocaleString()} Sold</span>
          </div>
        </div>
      </div>
    </Link>
  );
};

export default BundleCard;

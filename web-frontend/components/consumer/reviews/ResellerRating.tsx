'use client';

import React, { useState } from 'react';
import { Star, StarHalf, ChevronDown, ChevronUp } from 'lucide-react';
import { Review } from '@/types/reviews';
import { convertRatingToFiveScale } from '@/lib/utils/rating';

interface ResellerRatingProps {
  resellerId: string;
  resellerName: string;
  averageRating: number;
  reviewCount: number;
  reviews: Review[];
}

export default function ResellerRating({
  resellerId,
  resellerName,
  averageRating,
  reviewCount,
  reviews,
}: ResellerRatingProps) {
  const [showReviews, setShowReviews] = useState(false);

  const renderStars = (rating: number) => {
    const convertedRating = convertRatingToFiveScale(rating);
    const stars = [];
    const fullStars = Math.floor(convertedRating);
    const hasHalfStar = convertedRating % 1 >= 0.5;

    for (let i = 0; i < fullStars; i++) {
      stars.push(<Star key={`star-${i}`} className="w-4 h-4 text-yellow-400 fill-current" />);
    }

    if (hasHalfStar) {
      stars.push(<StarHalf key="half-star" className="w-4 h-4 text-yellow-400 fill-current" />);
    }

    const emptyStars = 5 - stars.length;
    for (let i = 0; i < emptyStars; i++) {
      stars.push(<Star key={`empty-${i}`} className="w-4 h-4 text-gray-300" />);
    }

    return stars;
  };

  return (
    <div className="space-y-2">
      <div 
        className="flex items-center gap-2 cursor-pointer"
        onClick={() => setShowReviews(!showReviews)}
      >
        <div className="flex items-center gap-1">
          {renderStars(averageRating)}
        </div>
        <span className="text-sm text-gray-600">
          ({reviewCount} {reviewCount === 1 ? 'review' : 'reviews'})
        </span>
        {showReviews ? (
          <ChevronUp className="w-4 h-4 text-gray-500" />
        ) : (
          <ChevronDown className="w-4 h-4 text-gray-500" />
        )}
      </div>

      {showReviews && (
        <div className="mt-4 space-y-4">
          {reviews.length === 0 ? (
            <p className="text-sm text-gray-500">No reviews yet</p>
          ) : (
            reviews.map((review) => (
              <div key={review.id} className="border-t pt-4">
                <div className="flex items-center justify-between mb-2">
                  <span className="font-medium">{review.userName}</span>
                  <div className="flex items-center gap-1">
                    {renderStars(review.rating)}
                  </div>
                </div>
                <p className="text-sm text-gray-600">{review.comment}</p>
                <p className="text-xs text-gray-400 mt-2">
                  {new Date(review.createdAt).toLocaleDateString()}
                </p>
              </div>
            ))
          )}
        </div>
      )}
    </div>
  );
} 
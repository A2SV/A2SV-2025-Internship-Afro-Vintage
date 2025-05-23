'use client';

import { useState, useEffect } from 'react';
import Image from 'next/image';
import { Star, X } from 'lucide-react';
import { Item } from '@/types/marketplace';
import { useCart } from '@/context/CartContext';
import { getUserById } from '@/lib/api/marketplace';
import { convertRatingToFiveScale } from '@/lib/utils/rating';

type ItemDetailsModalProps = {
  item: Item;
  onClose: () => void;
  isOpen: boolean;
};

export default function ItemDetailsModal({ item, onClose, isOpen }: ItemDetailsModalProps) {
  const { addToCart, isInCart } = useCart();
  const [selectedSize, setSelectedSize] = useState('S');
  const [seller, setSeller] = useState<{ name: string; photo?: string } | null>(null);
  const sizes = ['S', 'M', 'L', 'XL'];

  useEffect(() => {
    if (isOpen && item && item.seller_id) {
      getUserById(item.seller_id).then((user) => {
        setSeller({
          name: user?.username || 'Unknown Seller',
          photo: user?.photo || '/images/avatar.png',
        });
      }).catch((err) => {
        console.error('Error fetching seller info:', err);
        setSeller({ name: 'Unknown Seller', photo: '/images/avatar.png' });
      });
    }
  }, [isOpen, item]);

  if (!isOpen) return null;

  const handleAddToCart = async () => {
    const itemWithSize = {
      ...item,
      size: selectedSize
    };
    const result = await addToCart(itemWithSize);
    if (result.success) {
      setTimeout(onClose, 1500);
    }
  };

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
      <div className="bg-white rounded-2xl max-w-3xl w-full mx-4 p-8 relative">
        <button
          onClick={onClose}
          className="absolute right-4 top-4 text-gray-400 hover:text-gray-600"
          aria-label="close"
        >
          <X className="w-6 h-6" />
        </button>

        <div className="grid grid-cols-2 gap-8">
          {/* Left side - Image */}
          <div className="aspect-square relative rounded-lg overflow-hidden">
            <Image
              src={item.image}
              alt={item.name}
              fill
              className="object-cover"
            />
          </div>

          {/* Right side - Details */}
          <div className="space-y-6">
            <h1 className="text-3xl font-medium">{item.name}</h1>

            {/* Seller info */}
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 relative rounded-full overflow-hidden">
                <Image
                  src={seller?.photo || '/images/avatar.png'}
                  alt={seller?.name || 'Seller'}
                  fill
                  className="object-cover"
                />
              </div>
              <div>
                <h3 className="text-teal-600 font-medium">{seller?.name}</h3>
                <div className="flex items-center gap-2">
                  <div className="flex">
                    {[1, 2, 3, 4, 5].map((star) => (
                      <Star 
                        key={star} 
                        size={16}
                        className={`${star <= (item.rating ? convertRatingToFiveScale(item.rating) : 0) ? 'fill-yellow-400 text-yellow-400' : 'text-gray-300'}`}
                      />
                    ))}
                  </div>
                  <span className="text-sm text-gray-600">
                    {item.rating ? convertRatingToFiveScale(item.rating).toFixed(1) : 'No rating'}
                  </span>
                </div>
              </div>
            </div>

            {/* Description */}
            <div>
              <h3 className="font-medium mb-2">Description:</h3>
              <ul className="text-gray-600 space-y-2">
                {item.description.split('\n').map((line, index) => (
                  <li key={index}>{line}</li>
                ))}
              </ul>
            </div>

            {/* Size */}
            <div>
              <h3 className="font-medium mb-2">Size</h3>
              <div className="flex gap-2">
                {sizes.map((size) => (
                  <button
                    key={size}
                    onClick={() => setSelectedSize(size)}
                    className={`w-8 h-8 rounded-lg font-medium ${
                      selectedSize === size
                        ? 'bg-teal-600 text-white'
                        : 'bg-gray-100 text-gray-900 hover:bg-gray-200'
                    }`}
                  >
                    {size}
                  </button>
                ))}
              </div>
            </div>

            {/* Price and Add to Cart */}
            <div className="flex items-center justify-between pt-4">
              <div>
                <div className="text-2xl font-medium text-teal-600">
                  ${item.price.toLocaleString()}
                </div>
              </div>
              <button
                onClick={handleAddToCart}
                disabled={isInCart(item.id)}
                className={`px-8 py-3 rounded-lg font-medium ${
                  isInCart(item.id)
                    ? 'bg-gray-100 text-gray-500'
                    : 'bg-teal-600 text-white hover:bg-teal-700'
                }`}
              >
                {isInCart(item.id) ? 'Already in Cart' : 'Add to Cart'}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
} 
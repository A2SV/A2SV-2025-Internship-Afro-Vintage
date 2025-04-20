import Image from 'next/image';
import { ItemPreview } from '@/types/marketplace';

interface ItemCardProps {
  item: ItemPreview;
}

export default function ItemCard({ item }: ItemCardProps) {
  return (
    <div className="group relative bg-white rounded-lg overflow-hidden">
      <div className="relative h-64 w-full">
        <Image
          src={item.thumbnailUrl}
          alt={item.title}
          fill
          className="object-cover"
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
          <div className="flex items-center gap-1">
            <svg className="w-4 h-4 text-yellow-400" fill="currentColor" viewBox="0 0 20 20">
              <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
            </svg>
            <span className="text-sm text-gray-600">{item.rating}</span>
          </div>
        </div>
      </div>
    </div>
  );
} 
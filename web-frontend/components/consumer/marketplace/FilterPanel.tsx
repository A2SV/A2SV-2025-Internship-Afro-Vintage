'use client';

import { useState } from 'react';
import { X } from 'lucide-react';

export type FilterValues = {
  search: string;
  category: string[];
  size: string[];
  priceRange: {
    min: number;
    max: number;
  };
  grade: string[];
};

type FilterPanelProps = {
  onFilterChange: (filters: FilterValues) => void;
  onClearAll: () => void;
  className?: string;
};

const categories = ['shirt', 'suit', 'jacket', 'pants', 'dress'];
const sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
const grades = ['A', 'B', 'C', 'D'];

export const FilterPanel = ({ onFilterChange, onClearAll, className = '' }: FilterPanelProps) => {
  const [filters, setFilters] = useState<FilterValues>({
    search: '',
    category: [],
    size: [],
    priceRange: {
      min: 0,
      max: 10000,
    },
    grade: [],
  });

  function handleFilterChange(type: 'search', value: string): void;
  function handleFilterChange(type: 'priceRange', value: { min: number; max: number }): void;
  function handleFilterChange(type: 'category' | 'size' | 'grade', value: string): void;
  function handleFilterChange(
    type: keyof FilterValues,
    value: any
  ) {
    const newFilters = { ...filters };

    if (type === 'search') {
      newFilters.search = value;
    } else if (type === 'priceRange') {
      newFilters.priceRange = value;
    } else if (Array.isArray(newFilters[type])) {
      const currentArray = newFilters[type] as string[];
      
      if (currentArray.includes(value)) {
        newFilters[type] = currentArray.filter(item => item !== value);
      } else {
        newFilters[type] = [...currentArray, value];
      }
    }

    setFilters(newFilters);
    onFilterChange(newFilters);
  };

  const clearFilters = () => {
    const resetFilters: FilterValues = {
      search: '',
      category: [],
      size: [],
      priceRange: {
        min: 0,
        max: 10000,
      },
      grade: [],
    };
    setFilters(resetFilters);
    onFilterChange(resetFilters);
    onClearAll();
  };

  return (
    <div className={`bg-white p-4 rounded-lg shadow ${className}`}>
      <div className="flex justify-between items-center mb-4">
        <h2 className="text-lg font-semibold text-gray-900">Filters</h2>
        <button
          onClick={clearFilters}
          className="text-sm text-teal-600 hover:text-teal-700 flex items-center"
        >
          <X className="w-4 h-4 mr-1" />
          Clear all
        </button>
      </div>

      {/* Categories */}
      <div className="mb-6">
        <h3 className="text-sm font-medium text-gray-900 mb-2">Category</h3>
        <div className="space-y-2">
          {categories.map((category) => (
            <label key={category} className="flex items-center">
              <input
                type="checkbox"
                checked={filters.category.includes(category)}
                onChange={() => handleFilterChange('category', category)}
                className="w-4 h-4 text-teal-600 border-gray-300 rounded focus:ring-teal-500"
              />
              <span className="ml-2 text-sm text-gray-700">{category}</span>
            </label>
          ))}
        </div>
      </div>

      {/* Sizes */}
      <div className="mb-6">
        <h3 className="text-sm font-medium text-gray-900 mb-2">Size</h3>
        <div className="flex flex-wrap gap-2">
          {sizes.map((size) => (
            <button
              key={size}
              onClick={() => handleFilterChange('size', size)}
              className={`px-3 py-1 text-sm rounded-full border ${
                filters.size.includes(size)
                  ? 'bg-teal-600 text-white border-teal-600'
                  : 'border-gray-300 text-gray-700 hover:border-teal-600'
              }`}
            >
              {size}
            </button>
          ))}
        </div>
      </div>

      {/* Price Range */}
      <div className="mb-6">
        <h3 className="text-sm font-medium text-gray-900 mb-2">Price Range</h3>
        <div className="flex items-center space-x-4">
          <input
            type="number"
            value={filters.priceRange.min}
            onChange={(e) =>
              handleFilterChange('priceRange', {
                ...filters.priceRange,
                min: Number(e.target.value),
              })
            }
            placeholder="Min"
            className="w-24 px-3 py-2 border border-gray-200 rounded-lg focus:outline-none focus:border-teal-500"
          />
          <span className="text-gray-500">to</span>
          <input
            type="number"
            value={filters.priceRange.max}
            onChange={(e) =>
              handleFilterChange('priceRange', {
                ...filters.priceRange,
                max: Number(e.target.value),
              })
            }
            placeholder="Max"
            className="w-24 px-3 py-2 border border-gray-200 rounded-lg focus:outline-none focus:border-teal-500"
          />
        </div>
      </div>

      {/* Grade */}
      <div className="mb-6">
        <h3 className="text-sm font-medium text-gray-900 mb-2">Grade</h3>
        <div className="space-y-2">
          {grades.map((grade) => (
            <label key={grade} className="flex items-center">
              <input
                type="checkbox"
                checked={filters.grade.includes(grade)}
                onChange={() => handleFilterChange('grade', grade)}
                className="w-4 h-4 text-teal-600 border-gray-300 rounded focus:ring-teal-500"
              />
              <span className="ml-2 text-sm text-gray-700">{grade}</span>
            </label>
          ))}
        </div>
      </div>
    </div>
  );
};

export default FilterPanel; 
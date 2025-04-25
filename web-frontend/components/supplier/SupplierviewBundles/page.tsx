"use client";
import React, { useState } from "react";

interface Product {
  id: number;
  name: string;
  price: number;
  rating?: number;
  image: string;
  discountedPrice?: number;
  bundleName?: string;
  owner?: {
    name: string;
    profilePic: string;
    rating: number;
    reviews: number;
  };
  description?: string;
}

const ProductGrid: React.FC = () => {
  const [selectedProduct, setSelectedProduct] = useState<Product | null>(null);

  const products: Product[] = [
    {
      id: 1,
      name: "Nike Sportswear Club Fleece",
      price: 99,
      rating: 4.8,
      image: "/tshert.png",
      bundleName: "Casual Bundle",
      owner: {
        name: "Jake Santiago",
        profilePic: "/avatar.jpeg",
        rating: 4.8,
        reviews: 234,
      },
      description: `A cool and eco-friendly bundle perfect for daily wear, blending style with sustainability.
      
Features:
- 100% Organic Cotton
- Moisture-wicking technology
- Ribbed cuffs and hem
- Available in 5 colors
- Machine washable
- Slim fit design`,
    },
    {
      id: 2,
      name: "Trail Running Jacket Nike Windrunner",
      price: 150,
      rating: 4.9,
      image: "/fulltra.png",
      bundleName: "Outdoor Bundle",
      owner: {
        name: "Jake Santiago",
        profilePic: "/avatar.jpeg",
        rating: 4.8,
        reviews: 234,
      },
      description: `Professional running jacket designed for all weather conditions:
      
- Water-resistant outer layer
- Breathable mesh lining
- Adjustable hood
- Multiple pockets
- Reflective elements
- Lightweight design (only 450g)`,
    },
    {
      id: 3,
      name: "Premium Cotton Hoodie",
      price: 79,
      rating: 4.7,
      image: "/tshert.png",
      bundleName: "Comfort Bundle",
      description: `Ultra-soft hoodie for everyday comfort:
      
- 400gsm heavy cotton
- Kangaroo pocket
- Adjustable drawstrings
- Unisex sizing
- Pre-washed fabric
- Available in 8 colors
- Oversized fit option`,
    },
    {
      id: 4,
      name: "Designer Leather Jacket",
      price: 299,
      rating: 4.9,
      image: "/fulltra.png",
      bundleName: "Luxury Bundle",
      description: `Premium genuine leather jacket with superior craftsmanship:
      
- Full grain leather
- Removable wool liner
- Multiple inner pockets
- YKK zippers
- Hand-stitched seams
- Available in black and brown
- Lifetime warranty`,
    },
    {
      id: 5,
      name: "Athletic Shorts Set",
      price: 59,
      rating: 4.6,
      image: "/tshert.png",
      bundleName: "Sports Bundle",
      description: `Performance-oriented athletic wear:
      
- Quick-dry fabric
- UV protection 50+
- Elastic waistband
- Mesh ventilation
- Anti-odor technology
- 7-inch inseam
- Available in 3 color combinations`,
    },
    {
      id: 6,
      name: "Winter Thermal Set",
      price: 129,
      rating: 4.8,
      image: "/fulltra.png",
      bundleName: "Winter Bundle",
      description: `Extreme cold weather protection:
      
- Thermal-lined interior
- Waterproof outer layer
- Adjustable snow skirt
- Removable hood
- Ski pass pocket
- Reinforced seams
- Temperature rating: -20°C/-4°F`,
    },
  ];

  return (
    <div className="container mx-auto px-4 py-8">
      {/* Header */}
      <div className="flex items-center justify-between mb-8">
        <div className="flex items-center gap-6">
          <h2 className="text-2xl font-bold text-black">Type</h2>
          <div className="flex gap-4">
            <button className="px-4 py-2 bg-black text-white rounded-full">
              #2025
            </button>
            <button className="px-4 py-2 bg-gray-100 rounded-full text-black">
              Hoodie
            </button>
            <button className="px-4 py-2 bg-gray-100 rounded-full text-black">
              Men
            </button>
          </div>
        </div>
        <a href="#" className="text-blue-600 hover:underline">
          View All
        </a>
      </div>

      {/* Product Grid */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {products.map((product) => (
          <div
            key={product.id}
            className="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow"
          >
            <div
              className="cursor-pointer"
              onClick={() => setSelectedProduct(product)}
            >
              <img
                src={product.image}
                alt={product.name}
                className="w-full h-64 object-cover"
              />
            </div>

            <div className="p-4">
              <h3 className="font-semibold text-lg mb-2 text-black">
                {product.name}
              </h3>
              <div className="flex items-center gap-2 mb-2 text-black">
                <span className="font-bold">${product.price}</span>
              </div>
              {product.rating && (
                <div className="flex items-center gap-2">
                  <svg
                    className="w-4 h-4 text-yellow-400"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                  </svg>
                  <span className="text-sm text-black">{product.rating}</span>
                </div>
              )}
            </div>
          </div>
        ))}
      </div>

      {/* Modal */}
      {selectedProduct && (
        <div className="fixed inset-0 backdrop-blur-sm bg-white/30 flex justify-center items-center z-50">
          <div className="bg-white p-8 rounded-2xl shadow-2xl w-full max-w-6xl relative">
            <button
              className="absolute top-4 right-4 text-gray-500 hover:text-black text-2xl p-2"
              onClick={() => setSelectedProduct(null)}
            >
              ✕
            </button>

            <div className="flex flex-col md:flex-row gap-8">
              <img
                src={selectedProduct.image}
                alt={selectedProduct.name}
                className="w-full md:w-1/2 h-96 object-cover rounded-lg"
              />
              <div className="flex-1 space-y-4">
                <h2 className="text-3xl font-bold mb-4 text-black">
                  {selectedProduct.bundleName}
                </h2>

                {selectedProduct.owner && (
                  <div className="flex items-center gap-3 mb-4">
                    <img
                      src={selectedProduct.owner.profilePic}
                      alt={selectedProduct.owner.name}
                      className="w-10 h-10 rounded-full"
                    />
                    <div>
                      <p className="text-sm font-semibold text-black">
                        {selectedProduct.owner.name}
                      </p>
                      <p className="text-xs text-gray-500">
                        {selectedProduct.owner.rating} ⭐ (
                        {selectedProduct.owner.reviews} reviews)
                      </p>
                    </div>
                  </div>
                )}

                <p className="text-lg leading-relaxed text-gray-700 whitespace-pre-line">
                  {selectedProduct.description}
                </p>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default ProductGrid;

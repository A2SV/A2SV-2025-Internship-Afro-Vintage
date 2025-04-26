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
    <div className="container mx-auto px-4 py-8 bg-white">
      {/* Header */}
      <div className="flex items-center justify-between mb-8">
        <div className="flex items-center gap-6">
          <h2 className="text-2xl font-bold text-black">Recommended Bundles</h2>
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
      {/* Modal */}
      {selectedProduct && (
        <div className="fixed inset-0 backdrop-blur-sm bg-white/30 flex justify-center items-start z-50 pt-8">
          <div className="bg-white p-2 rounded-xl shadow-2xl w-full max-w-4xl mx-2 relative">
            {/* Close button */}
            <button
              className="absolute top-1 right-1 text-gray-500 hover:text-black text-base p-1"
              onClick={() => setSelectedProduct(null)}
            >
              ✕
            </button>

            <div className="flex flex-col md:flex-row gap-2 h-[80vh]">
              {/* Image (Only visible on large screens) */}
              <div className="md:w-1/2 w-full h-full flex justify-center items-center hidden md:block">
                <img
                  src={selectedProduct.image}
                  alt={selectedProduct.name}
                  className="w-full h-auto max-h-[80vh] object-contain rounded-lg"
                />
              </div>

              {/* Right section (always visible) */}
              <div className="flex-1 flex flex-col justify-between overflow-y-auto p-2 space-y-3 text-xs">
                <div className="space-y-3">
                  {/* Bundle Name */}
                  <h2 className="text-sm font-bold text-black">
                    {selectedProduct.bundleName}
                  </h2>

                  {/* Owner + Badge */}
                  {selectedProduct.owner && (
                    <div className="flex items-center gap-2">
                      <img
                        src={selectedProduct.owner.profilePic}
                        alt={selectedProduct.owner.name}
                        className="w-6 h-6 rounded-full"
                      />
                      <div>
                        <p className="text-xs font-semibold text-black">
                          {selectedProduct.owner.name}
                        </p>
                        <p className="text-[10px] text-gray-500">
                          {selectedProduct.owner.rating} ⭐ (
                          {selectedProduct.owner.reviews} reviews)
                        </p>
                      </div>
                      <span className="ml-2 px-2 py-0.5 text-[10px] bg-green-100 text-green-700 rounded-full">
                        Ready to Ship
                      </span>
                    </div>
                  )}

                  {/* Description */}
                  <p className="text-gray-700 leading-relaxed whitespace-pre-line">
                    {selectedProduct.description}
                  </p>

                  {/* Type & Quantity */}
                  <div className="flex gap-6 mt-2">
                    <div>
                      <h4 className="font-semibold text-black text-xs">
                        Quantity
                      </h4>
                    </div>
                  </div>

                  {/* Grade selection */}
                  <div className="mt-2">
                    <h4 className="font-semibold text-black text-xs">Grade</h4>
                    <div className="flex gap-2 mt-1">
                      {["A", "B", "C", "D"].map((grade) => (
                        <button
                          key={grade}
                          className="w-8 h-8 border rounded-full flex items-center justify-center text-black font-semibold text-xs hover:bg-black hover:text-white transition"
                        >
                          {grade}
                        </button>
                      ))}
                    </div>
                  </div>
                </div>

                {/* Buy button */}
                <div className="mt-3">
                  <button className="w-full bg-teal-600 hover:bg-teal-700 text-white font-bold py-1.5 rounded-xl text-xs">
                    Buy Bundle
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default ProductGrid;

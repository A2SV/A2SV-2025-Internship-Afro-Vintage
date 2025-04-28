'use client';

import { useEffect, useState } from 'react';
import Image from 'next/image';
import { toast } from 'react-hot-toast';

interface Bundle {
  ID: string;
  Title: string;
  SampleImage: string;
  Price: number;
  Type: string;
  DeclaredRating: number;
}

export default function MarketplacePage() {
  const [bundles, setBundles] = useState<Bundle[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);
  const [buying, setBuying] = useState<string | null>(null);

  // Fetch available bundles
  const fetchBundles = async () => {
    try {
      setLoading(true);
      const token = localStorage.getItem('token');
      if (!token) throw new Error('No token found');

      const res = await fetch('http://localhost:8081/bundles/available', {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      if (!res.ok) throw new Error('Failed to fetch bundles');

      const result = await res.json();
      setBundles(result.data);
    } catch (err) {
      console.error('❌ Error fetching bundles:', err);
      setError(true);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchBundles();
  }, []);

  // Handle bundle purchase
  const handleBuyBundle = async (bundleId: string) => {
    try {
      const token = localStorage.getItem('token');
      if (!token) throw new Error('No token found');

      setBuying(bundleId);

      const res = await fetch('http://localhost:8081/orders', { // ✅ Correct endpoint
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({ bundle_id: bundleId }), // ✅ Correct key: bundle_id
      });
      if (!res.ok) {
        const errData = await res.json();
        throw new Error(errData.message || 'Failed to purchase bundle');
      }

      toast.success('✅ Bundle purchased successfully!');

// Force refresh dashboard because new warehouse data added
setTimeout(() => {
  window.location.href = "/reseller/dashboard";
}, 300);  // 🔄 Refresh bundles list
    } catch (err: any) {
      console.error('❌ Error purchasing bundle:', err);
      toast.error(err.message || 'Failed to purchase');
    } finally {
      setBuying(null);
    }
  };

  if (loading) {
    return <div className="text-center text-lg mt-10">Loading marketplace...</div>;
  }

  if (error) {
    return (
      <div className="text-center text-lg text-red-500 mt-10">
        Failed to load marketplace. Please try again later.
      </div>
    );
  }

  return (
    <div className="p-6">
      <h1 className="text-3xl font-bold mb-8 text-[#006666] text-center">Marketplace</h1>

      {(bundles?.length ?? 0) === 0 ? (
        <div className="text-center text-gray-500">No bundles available.</div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
          {bundles.map((bundle) => (
            <div key={bundle.ID} className="bg-white rounded-lg shadow p-4 hover:shadow-lg transition">
              <div className="relative w-full h-40 mb-4">
                {bundle.SampleImage ? (
                  <Image
                    src={bundle.SampleImage}
                    alt={bundle.Title}
                    fill
                    className="object-cover rounded-md"
                    unoptimized
                  />
                ) : (
                  <div className="w-full h-full bg-gray-200 flex items-center justify-center rounded-md">
                    <span className="text-gray-500">No Image</span>
                  </div>
                )}
              </div>

              <h2 className="text-lg font-semibold text-[#1C1D22]">{bundle.Title}</h2>
              <p className="text-sm text-gray-500 mt-1">Type: {bundle.Type}</p>
              <p className="text-sm text-gray-500 mt-1">
                Declared Rating: {bundle.DeclaredRating ?? 0}%
              </p>
              <p className="text-xl font-bold text-[#006666] mt-2">
                ${bundle.Price?.toFixed(2) ?? '0.00'}
              </p>

              <button
                className="w-full mt-4 py-2 bg-teal-600 hover:bg-teal-700 text-white rounded-xl font-semibold text-sm"
                onClick={() => handleBuyBundle(bundle.ID)}
                disabled={buying === bundle.ID}
              >
                {buying === bundle.ID ? 'Processing...' : 'Buy Bundle'}
              </button>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

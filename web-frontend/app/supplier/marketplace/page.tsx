'use client';

import { useEffect, useState } from 'react';
import Image from 'next/image';

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

  useEffect(() => {
    const fetchBundles = async () => {
      try {
        const token = localStorage.getItem('token');
        const res = await fetch('http://localhost:8080/bundles/available', {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });

        if (!res.ok) throw new Error('Failed to fetch bundles');

        const data: Bundle[] = await res.json();
        setBundles(data);
      } catch (err) {
        console.error('❌ Error fetching bundles:', err);
        setError(true);
      } finally {
        setLoading(false);
      }
    };

    fetchBundles();
  }, []);

  if (loading) {
    return <div className="text-center text-lg mt-10">Loading marketplace...</div>;
  }

  if (error) {
    return (
      <div className="text-center text-lg text-red-500 mt-10">
        Failed to load marketplace. Please try again.
      </div>
    );
  }

  return (
    <div className="p-6">
      <h1 className="text-3xl font-bold mb-8 text-[#006666] text-center">Marketplace</h1>

      {bundles.length === 0 ? (
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
                    unoptimized // if you're not using external image domains
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
                Declared Rating: {bundle.DeclaredRating || 0}%
              </p>
              <p className="text-xl font-bold text-[#006666] mt-2">
                ${bundle.Price?.toFixed(2) ?? '0.00'}
              </p>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

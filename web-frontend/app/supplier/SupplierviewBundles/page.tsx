'use client';

import { useEffect, useState } from 'react';
import Image from 'next/image';

interface Bundle {
  id: string;
  title: string;
  sample_image: string;
  price: number;
  status: string;
  declared_rating: number;
}

export default function ViewBundlesPage() {
  const [bundles, setBundles] = useState<Bundle[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);

  useEffect(() => {
    const fetchBundles = async () => {
      try {
        const token = localStorage.getItem('token');
        if (!token) throw new Error('No token found');

        const res = await fetch('http://localhost:8081/bundles', {
          headers: { Authorization: `Bearer ${token}` },
        });

        if (!res.ok) throw new Error('Failed to fetch bundles');

        const result = await res.json();
        setBundles(result?.data || []); // ✅ Corrected here
      } catch (err) {
        console.error('❌ Error fetching bundles:', err);
        setError(true);
      } finally {
        setLoading(false);
      }
    };

    fetchBundles();
  }, []);

  const handleDelete = async (bundleId: string) => {
    const confirmed = window.confirm('Are you sure you want to delete this bundle?');
    if (!confirmed) return;

    try {
      const token = localStorage.getItem('token');
      if (!token) throw new Error('No token found');

      const res = await fetch(`http://localhost:8081/bundles/${bundleId}`, {
        method: 'DELETE',
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      if (!res.ok) throw new Error('Failed to delete bundle');

      alert('✅ Bundle deleted successfully!');
      setBundles((prev) => prev.filter((b) => b.id !== bundleId));
    } catch (err) {
      console.error('❌ Error deleting bundle:', err);
      alert('Failed to delete bundle. Please try again.');
    }
  };

  if (loading) {
    return (
      <div className="text-center text-lg mt-10 text-gray-500">
        Loading your bundles...
      </div>
    );
  }

  if (error) {
    return (
      <div className="text-center text-lg mt-10 text-red-500">
        Failed to load bundles. Please try again later.
      </div>
    );
  }

  return (
    <div className="p-6">
      <h1 className="text-3xl font-bold mb-8 text-center text-[#006666]">
        My Bundles
      </h1>

      {bundles.length === 0 ? (
        <div className="text-center text-gray-500">
          No bundles found.
        </div>
      ) : (
        <div className="overflow-x-auto">
          <table className="min-w-full bg-white shadow-md rounded-lg overflow-hidden">
            <thead className="bg-gray-100 text-gray-700 text-sm">
              <tr>
                <th className="py-3 px-4 text-left">Image</th>
                <th className="py-3 px-4 text-left">Title</th>
                <th className="py-3 px-4 text-left">Price ($)</th>
                <th className="py-3 px-4 text-left">Status</th>
                <th className="py-3 px-4 text-left">Declared Rating (%)</th>
                <th className="py-3 px-4 text-center">Actions</th>
              </tr>
            </thead>
            <tbody>
              {bundles.map((bundle) => (
                <tr key={bundle.id} className="border-t hover:bg-gray-50">
                  <td className="py-3 px-4">
                    {bundle.sample_image ? (
                      <div className="relative w-16 h-16">
                        <Image
                          src={bundle.sample_image}
                          alt={bundle.title}
                          fill
                          className="object-cover rounded-md"
                        />
                      </div>
                    ) : (
                      <div className="w-16 h-16 bg-gray-200 flex items-center justify-center rounded-md text-gray-400">
                        No Image
                      </div>
                    )}
                  </td>
                  <td className="py-3 px-4">{bundle.title}</td>
                  <td className="py-3 px-4">${bundle.price.toFixed(2)}</td>
                  <td className="py-3 px-4 capitalize">{bundle.status}</td>
                  <td className="py-3 px-4">{bundle.declared_rating}%</td>
                  <td className="py-3 px-4 text-center">
  {bundle.status.toLowerCase() === 'available' ? (
    <button
      onClick={() => handleDelete(bundle.id)}
      className="text-red-500 hover:underline text-sm"
    >
      Delete
    </button>
  ) : (
    <span className="text-gray-400 text-xl">-</span>
  )}
</td>


                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}

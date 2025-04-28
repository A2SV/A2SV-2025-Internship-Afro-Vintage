"use client";

import { useEffect, useState } from "react";
import Image from "next/image";
import UnpackForm from "@/components/warehouse/UnpackForm";

interface WarehouseItem {
  ID: string;
  BundleID: string; // ✅ Added this field
  Title: string;
  SampleImage: string;
  DeclaredRating: number;
  RemainingItemCount: number;
  Status: string;
}

export default function WarehousePage() {
  const [items, setItems] = useState<WarehouseItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);

  // Unpack Modal states
  const [isUnpackModalOpen, setIsUnpackModalOpen] = useState(false);
  const [selectedItem, setSelectedItem] = useState<WarehouseItem | null>(null);

  const fetchWarehouseItems = async () => {
    try {
      setLoading(true);
      const token = localStorage.getItem("token");
      if (!token) throw new Error("No token found");

      const res = await fetch("http://localhost:8081/warehouse", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      if (!res.ok) throw new Error("Failed to fetch warehouse items");

      const result = await res.json();

      const warehouseItems: WarehouseItem[] = (result || []).map((item: any) => ({
        ID: item.id,
        BundleID: item.bundle_id, // ✅ Mapping bundle_id
        Title: item.title,
        SampleImage: item.sample_image,
        DeclaredRating: item.declared_rating ?? 0,
        RemainingItemCount: item.remaining_items ?? 0,
        Status: item.status ?? "",
      }));

      setItems(warehouseItems);
    } catch (err) {
      console.error("❌ Error fetching warehouse:", err);
      setError(true);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchWarehouseItems();
  }, []);

  const openUnpackModal = (item: WarehouseItem) => {
    setSelectedItem(item);
    setIsUnpackModalOpen(true);
  };

  const closeUnpackModal = () => {
    setSelectedItem(null);
    setIsUnpackModalOpen(false);
    fetchWarehouseItems(); // ✅ Refresh warehouse after unpack
  };

  if (loading) {
    return <div className="text-center text-lg mt-10">Loading your warehouse...</div>;
  }

  if (error) {
    return (
      <div className="text-center text-lg text-red-500 mt-10">
        Failed to load warehouse. Please try again later.
      </div>
    );
  }

  return (
    <div className="p-6">
      <h1 className="text-3xl font-bold mb-8 text-[#006666] text-center">My Warehouse</h1>

      {(items?.length ?? 0) === 0 ? (
        <div className="text-center text-gray-500">No bundles in warehouse yet.</div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
          {items.map((item) => (
            <div
              key={item.ID}
              className="bg-white rounded-lg shadow p-4 hover:shadow-lg transition"
            >
              <div className="relative w-full h-40 mb-4">
                {item.SampleImage ? (
                  <Image
                    src={item.SampleImage}
                    alt={item.Title}
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

              <h2 className="text-lg font-semibold text-[#1C1D22]">{item.Title}</h2>
              <p className="text-sm text-gray-500 mt-1">
                Declared Rating: {item.DeclaredRating ?? 0}%
              </p>
              <p className="text-sm text-gray-500 mt-1">
                Items Remaining: {item.RemainingItemCount ?? 0}
              </p>
              <p className="text-sm text-gray-500 mt-1">
                Status: {item.Status || "Unknown"}
              </p>

              {item.Status === "listed" && (
                <button
                  className="bg-blue-500 hover:bg-blue-600 text-white py-1 px-3 rounded mt-3"
                  onClick={() => openUnpackModal(item)}
                >
                  Unpack
                </button>
              )}
            </div>
          ))}
        </div>
      )}

      {/* Unpack Modal */}
      {isUnpackModalOpen && selectedItem && (
        <div className="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center z-50">
          <div className="bg-white p-6 rounded-lg w-full max-w-md">
            <h2 className="text-xl font-bold mb-4">
              Unpack Item from {selectedItem.Title}
            </h2>
            <UnpackForm bundle={selectedItem} onClose={closeUnpackModal} />
          </div>
        </div>
      )}
    </div>
  );
}

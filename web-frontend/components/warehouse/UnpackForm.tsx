'use client';

import { useState } from 'react';

type WarehouseItem = {
  ID: string;
  BundleID: string; 
  Title: string;
  SampleImage: string;
  DeclaredRating: number;
  RemainingItemCount: number;
  Status: string;
};

type UnpackFormProps = {
  bundle: WarehouseItem;
  onClose: () => void;
};

export default function UnpackForm({ bundle, onClose }: UnpackFormProps) {
  const [title] = useState(bundle.Title || ''); // Prefilled, not editable
  const [photoFile, setPhotoFile] = useState<File | null>(null);
  const [size, setSize] = useState('');
  const [grade, setGrade] = useState('');
  const [price, setPrice] = useState<number>(0);
  const [rating, setRating] = useState<number>(80);  // ✅ Default rating to 80
  const [description, setDescription] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!photoFile) {
      alert('Please upload a photo.');
      return;
    }
    if (!size) {
      alert('Please enter size.');
      return;
    }
    if (price <= 0) {
      alert('Please enter a valid price.');
      return;
    }

    const reader = new FileReader();
    reader.onloadend = async () => {
      const base64String = reader.result as string;

      const requestBody = {
        title: title,
        image_url: base64String,
        size: size,
        grade: grade,
        price: price,
        description: description,
        bundle_id: bundle.BundleID,   // ✅ correct bundle_id here
        rating: rating,
      };
      
      

      try {
        const token = localStorage.getItem('token');
        const res = await fetch('http://localhost:8081/products', {
          method: 'POST',
          headers: {
            Authorization: `Bearer ${token}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(requestBody),
        });

        if (!res.ok) throw new Error('Failed to unpack item');
        alert('Item unpacked successfully!');
        onClose();
      } catch (error) {
        console.error('Error unpacking:', error);
        alert('Error during unpacking.');
      }
    };

    reader.readAsDataURL(photoFile);
  };

  return (
    <form onSubmit={handleSubmit} className="flex flex-col gap-4 p-4">
      <h2 className="text-xl font-semibold text-center mb-4">
        Unpack Item from {bundle.Title}
      </h2>

      <input
        type="text"
        value={title}
        readOnly
        className="border p-2 bg-gray-100 text-gray-700"
      />

      <input
        type="file"
        onChange={(e) => setPhotoFile(e.target.files?.[0] || null)}
        required
        className="border p-2"
      />

      <input
        type="text"
        placeholder="Size (e.g., S, M, L)"
        value={size}
        onChange={(e) => setSize(e.target.value)}
        required
        className="border p-2"
      />

      <select
        value={grade}
        onChange={(e) => setGrade(e.target.value)}
        className="border p-2"
      >
        <option value="">Select Grade (optional)</option>
        <option value="A+">A+</option>
        <option value="A">A</option>
        <option value="B">B</option>
        <option value="C">C</option>
      </select>

      <input
        type="number"
        placeholder="Price (in dollars)"
        value={price}
        onChange={(e) => setPrice(Number(e.target.value))}
        min="0.01"
        step="0.01"
        required
        className="border p-2"
      />

      {/* ✅ New Rating input */}
      <input
        type="number"
        placeholder="Rating (0-100)"
        value={rating}
        onChange={(e) => setRating(Number(e.target.value))}
        min="0"
        max="100"
        required
        className="border p-2"
      />

      <textarea
        placeholder="Description (optional)"
        value={description}
        onChange={(e) => setDescription(e.target.value)}
        className="border p-2"
      />

      <div className="flex justify-end gap-4">
        <button
          type="button"
          onClick={onClose}
          className="bg-gray-400 hover:bg-gray-500 text-white py-2 px-4 rounded"
        >
          Cancel
        </button>

        <button
          type="submit"
          className="bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded"
        >
          Finish
        </button>
      </div>
    </form>
  );
}

"use client";

import { useState } from "react";

export default function AddBundlePage() {
  const [formData, setFormData] = useState({
    bundleName: "",
    category: "",
    quantity: "",
    grade: "",
    price: "",
    status: "",
    description: "",
    image: null,
  });

  const handleChange = (e: any) => {
    const { name, value, files } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: files ? files[0] : value,
    }));
  };

  const handleSubmit = (e: any) => {
    e.preventDefault();
  };

  return (
    <div className="min-h-screen bg-[#F5F5F5] p-10">
      <h1 className="text-2xl font-bold mb-6 text-[#006666]">Add Bundle</h1>

      {/* Bundle Types */}
      <div className="flex gap-6 mb-10">
        <div className="flex-1 text-white bg-[#006666] rounded-lg p-6 min-h-[150px] text-center shadow cursor-pointer flex flex-col justify-center">
          <p className="text-xl font-semibold">Sorted</p>
          <p className="text-sm mt-1">All items of the same Type</p>
        </div>

        <div className="flex-1 bg-white border border-gray-200 rounded-lg p-6 min-h-[150px] text-center shadow cursor-pointer flex flex-col justify-center">
          <p className="text-xl font-semibold">Unsorted</p>
          <p className="text-sm mt-1 text-gray-500">Mixed Clothing types</p>
        </div>
        <div className="flex-1 bg-white border border-gray-200 rounded-lg p-6 min-h-[150px] text-center shadow cursor-pointer flex flex-col justify-center">
          <p className="text-xl font-semibold">Semi-Sorted</p>
          <p className="text-sm mt-1 text-gray-500">Mostly One Category</p>
        </div>
      </div>

      {/* Form */}
      <form className="grid grid-cols-2 gap-6" onSubmit={handleSubmit}>
        <div>
          <label className="block mb-1 text-sm font-medium text-gray-700">
            Bundle Name
          </label>
          <input
            name="bundleName"
            type="text"
            placeholder="Enter Bundle Name"
            className="w-full border border-gray-300 px-4 py-2 rounded placeholder:text-black/70"
            onChange={handleChange}
          />
        </div>

        <div>
          <label className="block mb-1 text-sm font-medium text-gray-700">
            Category
          </label>
          <select
            name="category"
            className="w-full border border-gray-300 px-4 py-2 rounded text-black/70"
            onChange={handleChange}
          >
            <option value="">Select Category</option>
            <option value="jeans">Jeans</option>
            <option value="shirts">Shirts</option>
            <option value="jackets">Jackets</option>
          </select>
        </div>

        <div>
          <label className="block mb-1 text-sm font-medium text-gray-700">
            Quantity
          </label>
          <input
            name="quantity"
            type="number"
            placeholder="Number of Clothes"
            className="w-full border border-gray-300 px-4 py-2 rounded placeholder:text-black/70"
            onChange={handleChange}
          />
        </div>

        <div>
          <label className="block mb-1 text-sm font-medium text-gray-700">
            Grade
          </label>
          <select
            name="grade"
            className="w-full border border-gray-300 px-4 py-2 rounded text-black/70"
            onChange={handleChange}
          >
            <option value="">Select Grade</option>
            <option value="a">Type A</option>
            <option value="b">Type B</option>
          </select>
        </div>

        <div>
          <label className="block mb-1 text-sm font-medium text-gray-700">
            Price
          </label>
          <input
            name="price"
            type="text"
            placeholder="Enter Price"
            className="w-full border border-gray-300 px-4 py-2 rounded placeholder:text-black/70"
            onChange={handleChange}
          />
        </div>

        <div>
          <label className="block mb-1 text-sm font-medium text-gray-700">
            Status
          </label>
          <select
            name="status"
            className="w-full border border-gray-300 px-4 py-2 rounded text-black/70"
            onChange={handleChange}
          >
            <option value="">Select Status</option>
            <option value="available">Available</option>
            <option value="sold">Sold</option>
          </select>
        </div>

        <div className="col-span-2">
          <label className="block mb-1 text-sm font-medium text-gray-700">
            Description
          </label>
          <textarea
            name="description"
            placeholder="Write a description..."
            rows={4}
            className="w-full border border-gray-300 px-4 py-2 rounded placeholder:text-black/70"
            onChange={handleChange}
          ></textarea>
        </div>

        <div className="col-span-2">
          <label className="block mb-2 text-sm font-medium text-gray-700">
            Upload Image
          </label>
          <div className="border-dashed border-2 border-gray-300 rounded-lg flex flex-col items-center justify-center py-10 text-gray-500 text-sm cursor-pointer">
            <input
              name="image"
              type="file"
              accept="image/*"
              className="hidden"
              id="upload"
              onChange={handleChange}
            />
            <label
              htmlFor="upload"
              className="cursor-pointer flex flex-col items-center"
            >
              <svg
                className="w-6 h-6 mb-2 text-gray-500"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                viewBox="0 0 24 24"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M4 16v1a2 2 0 002 2h12a2 2 0 002-2v-1M12 12v9m0 0l-3-3m3 3l3-3M4 4h16v4H4z"
                />
              </svg>
              <p>Click or drag image to upload</p>
            </label>
          </div>
        </div>

        <div className="col-span-2 flex justify-end gap-4">
          <button
            type="button"
            className="px-6 py-2 rounded border border-gray-400 text-gray-700 hover:bg-gray-100"
          >
            Cancel
          </button>
          <button
            type="submit"
            className="px-6 py-2 rounded bg-[#006666] text-white hover:bg-[#004D4D]"
          >
            Save Bundle
          </button>
        </div>
      </form>
    </div>
  );
}

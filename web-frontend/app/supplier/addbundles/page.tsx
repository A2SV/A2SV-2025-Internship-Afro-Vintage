"use client";

import { useState } from "react";

export default function AddBundlePage() {
  const [imagePreview, setImagePreview] = useState<string | null>(null);

  const [formData, setFormData] = useState({
    title: "",
    category: "",
    quantity: "",
    grade: "",
    declaredRating: "",
    price: "",
    status: "",
    description: "",
    sampleImage: null as File | null,
  });

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>
  ) => {
    const { name, value, files } = e.target as HTMLInputElement;
    if (files && files.length > 0) {
      const file = files[0];
      setFormData((prev) => ({ ...prev, [name]: file }));

      const reader = new FileReader();
      reader.onloadend = () => {
        setImagePreview(reader.result as string);
      };
      reader.readAsDataURL(file);
    } else {
      setFormData((prev) => ({ ...prev, [name]: value }));
    }
  };

  const toBase64 = (file: File): Promise<string> =>
    new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => resolve(reader.result as string);
      reader.onerror = reject;
    });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      const token = localStorage.getItem("token");
      if (!token) {
        alert("❌ You must be logged in to add a bundle.");
        return;
      }

      const {
        title,
        category,
        quantity,
        grade,
        declaredRating,
        price,
        status,
        description,
        sampleImage,
      } = formData;

      if (
        !title ||
        !category ||
        !grade ||
        !quantity ||
        !declaredRating ||
        !price ||
        !status ||
        !sampleImage
      ) {
        alert("❌ Please fill all required fields including image.");
        return;
      }

      const base64Image = await toBase64(sampleImage);

      const requestBody = {
        title,
        type: category,
        number_of_items: Number(quantity),
        grade,
        declared_rating: Number(declaredRating),
        price: Number(price),
        status,
        description,
        sample_image: base64Image,
        estimated_breakdown: null,
      };

      const res = await fetch("http://localhost:8080/bundles", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(requestBody),
      });

      const result = await res.json();
      if (!res.ok) throw new Error(result.message || "Failed to create bundle");

      alert("✅ Bundle created successfully!");
      setFormData({
        title: "",
        category: "",
        quantity: "",
        grade: "",
        declaredRating: "",
        price: "",
        status: "",
        description: "",
        sampleImage: null,
      });
      setImagePreview(null);
    } catch (error: any) {
      console.error("❌ Submission error:", error);
      alert(error.message || "Something went wrong");
    }

  };

  return (
    <div className="min-h-screen bg-[#F5F5F5] p-10">
      <h1 className="text-2xl font-bold mb-6 text-[#006666]">Add Bundle</h1>

      {/* Grade Selection */}
      <div className="flex gap-6 mb-10">
        {["sorted", "unsorted", "semi_sorted"].map((level) => (
          <div
            key={level}
            onClick={() => setFormData((prev) => ({ ...prev, grade: level }))}
            className={`flex-1 rounded-lg p-6 text-center shadow cursor-pointer transition-all duration-150 ${
              formData.grade === level
                ? "bg-[#006666] text-white"
                : "bg-white text-black border border-gray-300"
            }`}
          >
            <p className="text-xl font-semibold capitalize">
              {level.replace("_", "-")}
            </p>
            <p className="text-sm mt-1 text-gray-500">
              {level === "sorted" && "All items of the same Type"}
              {level === "unsorted" && "Mixed Clothing types"}
              {level === "semi_sorted" && "Mostly One Category"}
            </p>
          </div>
        ))}
      </div>

      {/* Form */}
      <form className="grid grid-cols-2 gap-6" onSubmit={handleSubmit}>
        <InputField label="Bundle Name" name="title" value={formData.title} onChange={handleChange} />

        <SelectField
          label="Category (Type)"
          name="category"
          value={formData.category}
          onChange={handleChange}
          options={["jeans", "shirts", "jackets"]}
        />

        <InputField label="Quantity" name="quantity" type="number" value={formData.quantity} onChange={handleChange} />

        <InputField
          label="Declared Rating (0–100)"
          name="declaredRating"
          type="number"
          value={formData.declaredRating}
          onChange={handleChange}
        />

        <InputField label="Price" name="price" type="number" value={formData.price} onChange={handleChange} />

        <SelectField
          label="Status"
          name="status"
          value={formData.status}
          onChange={handleChange}
          options={["available", "sold"]}
        />

        <div className="col-span-2">
          <label className="block mb-1 text-sm font-medium text-gray-700">Description</label>
          <textarea
            name="description"
            rows={4}
            value={formData.description}
            placeholder="Write a description..."
            className="w-full border border-gray-300 px-4 py-2 rounded"
            onChange={handleChange}
          ></textarea>
        </div>

        <div className="col-span-2">
          <label className="block mb-2 text-sm font-medium text-gray-700">
            Upload Image
          </label>
          <div className="border-dashed border-2 border-gray-300 rounded-lg py-10 text-center relative">
            {imagePreview ? (
              <img
                src={imagePreview}
                alt="Preview"
                className="mx-auto h-40 object-contain rounded"
              />
            ) : (
              <label htmlFor="upload" className="cursor-pointer text-gray-500">
                Click to upload image
              </label>
            )}
            <input
              name="sampleImage"
              type="file"
              accept="image/*"
              id="upload"
              className="hidden"
              onChange={handleChange}
            />
          </div>
        </div>

        <div className="col-span-2 flex justify-end gap-4">
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

// 🔧 Reusable Input Field Component
function InputField({ label, name, value, type = "text", onChange }: any) {
  return (
    <div>
      <label className="block mb-1 text-sm font-medium text-gray-700">
        {label}
      </label>
      <input
        name={name}
        type={type}
        value={value}
        placeholder={`Enter ${label}`}
        className="w-full border border-gray-300 px-4 py-2 rounded"
        onChange={onChange}
      />
    </div>
  );
}

// 🔧 Reusable Select Field Component
function SelectField({ label, name, value, onChange, options }: any) {
  return (
    <div>
      <label className="block mb-1 text-sm font-medium text-gray-700">
        {label}
      </label>
      <select
        name={name}
        value={value}
        className="w-full border border-gray-300 px-4 py-2 rounded"
        onChange={onChange}
      >
        <option value="">Select {label}</option>
        {options.map((opt: string) => (
          <option key={opt} value={opt}>
            {opt.charAt(0).toUpperCase() + opt.slice(1)}
          </option>
        ))}
      </select>
    </div>
  );
}

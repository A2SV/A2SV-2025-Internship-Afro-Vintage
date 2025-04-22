"use client";

import { LineChart, Line, BarChart, Bar, ResponsiveContainer } from "recharts";

const bundleData = [
  { value: 10 },
  { value: 30 },
  { value: 15 },
  { value: 20 },
  { value: 40 },
  { value: 10 },
  { value: 35 },
];
const salesData = [
  { value: 20 },
  { value: 10 },
  { value: 30 },
  { value: 25 },
  { value: 15 },
  { value: 45 },
  { value: 30 },
];

export default function DashboardPage() {
  return (
    <div className="space-y-6">
      {/* Top Stats */}
      <div className="grid grid-cols-3 gap-6">
        <div className="bg-white rounded-lg shadow p-5">
          <p className="text-xs text-gray-500 mb-1">Total Bundles</p>
          <h2 className="text-2xl font-semibold text-[#1C1D22]">24</h2>
          <ResponsiveContainer width="100%" height={50}>
            <BarChart data={bundleData}>
              <Bar
                dataKey="value"
                fill="#005B80"
                radius={[5, 5, 0, 0]}
                barSize={8}
              />
            </BarChart>
          </ResponsiveContainer>
        </div>

        <div className="bg-white rounded-lg shadow p-5">
          <p className="text-xs text-gray-500 mb-1">Bundles Sold</p>
          <h2 className="text-2xl font-semibold text-[#1C1D22]">18</h2>
          <ResponsiveContainer width="100%" height={50}>
            <LineChart data={salesData}>
              <Line
                type="linear"
                dataKey="value"
                stroke="#005B80"
                strokeWidth={2}
                dot={false}
              />
            </LineChart>
          </ResponsiveContainer>
        </div>

        <div className="bg-white rounded-lg shadow p-5 flex flex-col justify-between">
          <p className="text-xs text-gray-500 mb-1">Your Rating</p>
          <h2 className="text-3xl font-bold text-right text-[#1C1D22]">4.7</h2>
        </div>
      </div>

      {/* Middle Section */}
      <div className="grid grid-cols-2 gap-6">
        {/* Best Selling */}
        <div className="bg-white rounded-lg shadow">
          <div className="p-5 border-b">
            <p className="text-xs text-gray-500">Best Selling</p>
            <h2 className="text-xl font-semibold mt-1 text-[#1C1D22]">
              $2,400{" "}
              <span className="text-sm text-gray-500 font-normal">
                — Total Sales
              </span>
            </h2>
          </div>
          <div className="p-5 space-y-2">
            <div className="border border-gray-300 px-3 py-1.5 rounded-full inline-block text-sm text-gray-500">
              Classic Monochrome Tees —{" "}
              <span className="font-bold">$940 Sales</span>
            </div>
            <div className="border border-gray-300 px-3 py-1.5 rounded-full inline-block text-sm text-gray-500">
              Monochromatic Wardrobe —{" "}
              <span className="font-bold">$790 Sales</span>
            </div>
            <div className="border border-gray-300 px-3 py-1.5 rounded-full inline-block text-sm text-gray-500">
              Essential Neutrals — <span className="font-bold">$740 Sales</span>
            </div>
            <div className="mt-4 flex justify-center">
              <div className="w-24 h-24 rounded-full border-[10px] border-[#005B80]" />
            </div>
          </div>
        </div>

        {/* Bundles Table */}
        <div className="bg-white rounded-lg shadow">
          <div className="p-5 flex justify-between items-center border-b">
            <p className="text-xs text-gray-500">Bundles</p>
            <button className="text-xs text-[#005B80] border border-[#005B80] rounded-full px-4 py-1 hover:bg-[#005B80] hover:text-white transition">
              View All
            </button>
          </div>
          <div className="p-5">
            <table className="w-full text-sm text-left">
              <thead>
                <tr className="text-gray-500">
                  <th className="pb-2">Item</th>
                  <th className="pb-2">Date</th>
                  <th className="pb-2">Type</th>
                  <th className="pb-2">Status</th>
                </tr>
              </thead>
              <tbody className="text-gray-700 font-medium">
                <tr className="border-t">
                  <td className="py-2">Mens Black T-Shirts</td>
                  <td>20 Mar, 2023</td>
                  <td>Sorted</td>
                  <td>Available</td>
                </tr>
                <tr className="border-t">
                  <td className="py-2">Essential Neutrals</td>
                  <td>19 Mar, 2023</td>
                  <td>Unsorted</td>
                  <td>Sold</td>
                </tr>
                <tr className="border-t">
                  <td className="py-2">Sleek and Cozy Black</td>
                  <td>7 Feb, 2023</td>
                  <td>Sorted</td>
                  <td>Available</td>
                </tr>
                <tr className="border-t">
                  <td className="py-2">MOCKUP Black</td>
                  <td>29 Jan, 2023</td>
                  <td>Unsorted</td>
                  <td>Sold</td>
                </tr>
                <tr className="border-t">
                  <td className="py-2">Monochromatic Wardrobe</td>
                  <td>27 Jan, 2023</td>
                  <td>Sorted</td>
                  <td>Available</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
}

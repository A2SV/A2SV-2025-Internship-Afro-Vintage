"use client";
import { FaBell, FaSearch } from "react-icons/fa";
import { Bar, Line, Doughnut } from "react-chartjs-2";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  BarElement,
  LineElement,
  PointElement,
  Title,
  Tooltip,
  Legend,
  ArcElement,
} from "chart.js";
import type { ChartOptions } from "chart.js";

// Register Chart.js components
ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  LineElement,
  PointElement,
  Title,
  Tooltip,
  Legend,
  ArcElement
);

const chartContainerStyle = {
  width: "100%",
  height: "80px",
};

// Type-safe data generation function
const generateRandomData = (
  points: number,
  min: number,
  max: number
): number[] => {
  return Array.from(
    { length: points },
    () => Math.random() * (max - min) + min
  );
};

// Chart data configurations
const totalBundlesData = {
  labels: Array.from({ length: 12 }, (_, i) => `Week ${i + 1}`),
  datasets: [
    {
      data: generateRandomData(12, 5, 25),
      borderColor: "#00a3a3",
      borderWidth: 2,
      fill: false,
    },
  ],
};

const bundlesSoldData = {
  labels: Array.from({ length: 12 }, (_, i) => `Week ${i + 1}`),
  datasets: [
    {
      data: generateRandomData(12, 3, 20),
      borderColor: "#00a3a3",
      borderWidth: 2,
      fill: false,
    },
  ],
};

const ratingData = {
  labels: Array.from({ length: 12 }, (_, i) => `Week ${i + 1}`),
  datasets: [
    {
      data: generateRandomData(12, 4.0, 5.0),
      borderColor: "#00a3a3",
      borderWidth: 2,
      fill: false,
    },
  ],
};

const bestSellingChartData = {
  labels: [
    "Classic Monochrome Tees",
    "Monochromatic Wardrobe",
    "Essential Neutrals",
  ],
  datasets: [
    {
      data: [940, 790, 740],
      backgroundColor: ["#00a3a3", "#007777", "#008888"],
      hoverBackgroundColor: ["#005555", "#00a3a36", "#007777"],
    },
  ],
};

// Typed chart options
const chartOptions: ChartOptions<"line"> = {
  responsive: true,
  plugins: {
    legend: { display: false },
  },
  scales: {
    x: { display: false },
    y: { display: false },
  },
  maintainAspectRatio: false,
  elements: {
    line: {
      tension: 0.4,
    },
  },
};

interface StatCardProps {
  title: string;
  value: string | number;
  children: React.ReactNode;
}

function StatCard({ title, value, children }: StatCardProps) {
  return (
    <div className="bg-white p-5 rounded-lg shadow">
      <p className="text-gray-500 text-base mb-1">{title}</p>
      <h2 className="text-4xl font-semibold text-[#1C1D22]">{value}</h2>
      <div className="mt-2" style={chartContainerStyle}>
        {children}
      </div>
    </div>
  );
}

export default function DashboardPage() {
  return (
    <div className="space-y-6">
      {/* Header */}
      <header className="flex justify-between items-center">
        <div className="relative w-1/3">
          <span className="absolute inset-y-0 left-0 flex items-center pl-3">
            <FaSearch className="w-5 h-5 text-gray-500" />
          </span>
          <input
            type="text"
            placeholder="Search Bundles"
            className="border rounded-full px-4 py-2 pl-10 w-full bg-transparent placeholder-gray-500 text-gray-700"
          />
        </div>
        <div className="flex items-center gap-4">
          <FaBell className="text-gray-600 text-xl" />
          <div className="flex items-center gap-2">
            <div className="text-right">
              <p className="text-gray-800 font-bold">Jake Santiago</p>
              <p className="text-gray-600 text-sm">Supplier</p>
            </div>
            <img
              src="/avatar.jpeg"
              alt="User Avatar"
              className="w-10 h-10 rounded-full"
            />
          </div>
        </div>
      </header>

      {/* Top Stats */}
      <div className="grid grid-cols-3 gap-6">
        <StatCard title="Total Bundles" value="24">
          <Line data={totalBundlesData} options={chartOptions} />
        </StatCard>

        <StatCard title="Bundles Sold" value="18">
          <Line data={bundlesSoldData} options={chartOptions} />
        </StatCard>

        <div className="bg-white p-5 rounded-lg shadow flex flex-col justify-between">
          <p className="text-gray-500 text-base mb-1">Your Rating</p>
          <h2 className="text-5xl font-bold text-right text-[#1C1D22]">4.7</h2>
        </div>
      </div>

      {/* Middle Section */}
      <div className="grid grid-cols-2 gap-6">
        {/* Best Selling */}
        <div className="bg-white rounded-lg shadow">
          <div className="p-5 border-b">
            <p className="text-base text-gray-500">Best Selling</p>
            <h2 className="text-3xl font-semibold mt-1 text-[#1C1D22]">
              $2,400{" "}
              <span className="text-lg text-gray-500 font-normal">
                — Total Sales
              </span>
            </h2>
          </div>
          <div className="p-5 space-y-4">
            {bestSellingChartData.labels.map((label, index) => (
              <div
                key={index}
                className="block w-full border border-gray-300 px-4 py-2 rounded-full text-lg text-gray-500"
              >
                {label} —{" "}
                <span className="font-bold">
                  ${bestSellingChartData.datasets[0].data[index]} Sales
                </span>
              </div>
            ))}
            <div className="mt-6 flex justify-center">
              <div style={{ width: "150px", height: "150px" }}>
                <Doughnut
                  data={bestSellingChartData}
                  options={{
                    plugins: { legend: { display: false } },
                    maintainAspectRatio: false,
                    cutout: "70%",
                  }}
                />
              </div>
            </div>
          </div>
        </div>

        {/* Bundles Table */}
        <div className="bg-white rounded-lg shadow">
          <div className="p-5 flex justify-between items-center border-b">
            <p className="text-base text-gray-500">Bundles</p>
            <button className="text-base text-[#00a3a3] border border-[#00a3a3] rounded-full px-5 py-2 hover:bg-[#00a3a3] hover:text-white transition">
              View All
            </button>
          </div>
          <div className="p-5">
            <table className="w-full text-left">
              <thead>
                <tr className="text-gray-500">
                  <th className="pb-3">Item</th>
                  <th className="pb-3">Date</th>
                  <th className="pb-3">Type</th>
                  <th className="pb-3">Status</th>
                </tr>
              </thead>
              <tbody className="text-gray-700 font-medium">
                {[
                  [
                    "Mens Black T-Shirts",
                    "20 Mar, 2023",
                    "Sorted",
                    "Available",
                  ],
                  ["Essential Neutrals", "19 Mar, 2023", "Unsorted", "Sold"],
                  [
                    "Sleek and Cozy Black",
                    "7 Feb, 2023",
                    "Sorted",
                    "Available",
                  ],
                  ["MOCKUP Black", "29 Jan, 2023", "Unsorted", "Sold"],
                  [
                    "Monochromatic Wardrobe",
                    "27 Jan, 2023",
                    "Sorted",
                    "Available",
                  ],
                ].map((row, index) => (
                  <tr key={index} className="border-t">
                    <td className="py-3">{row[0]}</td>
                    <td>{row[1]}</td>
                    <td>{row[2]}</td>
                    <td>{row[3]}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
}

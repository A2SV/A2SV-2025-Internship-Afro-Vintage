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
  height: "50px",
};

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
    <div className="bg-white p-2 rounded-md shadow h-full">
      <p className="text-gray-500 text-xs mb-1">{title}</p>
      <h2 className="text-xl font-semibold text-[#1C1D22]">{value}</h2>
      <div className="mt-1" style={chartContainerStyle}>
        {children}
      </div>
    </div>
  );
}

export default function DashboardPage() {
  return (
    <div className="space-y-3 p-2">
      {/* Header Section */}
      <div className="flex flex-col md:flex-row md:items-center md:justify-between mb-6 px-2">
        <div className="mb-2 md:mb-0">
          <h1 className="text-2xl font-bold text-[#1C1D22]">Warehouse</h1>
        </div>
        <div className="flex flex-col items-start md:items-end gap-0">
          <h2 className="text-lg font-bold text-[#1C1D22]">Welcome Back!</h2>
          <div className=" text-gray-500 ">Hi, Choudary Aoun</div>
        </div>
      </div>

      {/* Top Stats */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
        <StatCard title="Bought Bundles" value="24">
          <Line data={totalBundlesData} options={chartOptions} />
        </StatCard>

        <div className="bg-white p-2 rounded-md shadow flex flex-col justify-between h-full">
          <p className="text-gray-500 text-xs mb-1">Your Rating</p>
          <h2 className="text-2xl font-bold text-right text-[#1C1D22]">4.7</h2>
        </div>
      </div>

      {/* Middle Section */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
        <StatCard title="Item Sold" value="18">
          <Line data={bundlesSoldData} options={chartOptions} />
        </StatCard>

        {/* Best Selling */}
        <div className="bg-white rounded-md shadow flex flex-col h-full">
          <div className="p-2 border-b">
            <p className="text-xs text-gray-500">Best Selling</p>
            <h2 className="text-lg font-semibold mt-1 text-[#1C1D22]">
              $2,400{" "}
              <span className="text-sm text-gray-500 font-normal">
                — Total Sales
              </span>
            </h2>
          </div>
          <div className="p-2 space-y-2 flex-1 flex flex-col justify-between">
            <div className="space-y-2">
              {bestSellingChartData.labels.map((label, index) => (
                <div
                  key={index}
                  className="block w-full border border-gray-300 px-2 py-1 rounded-full text-xs text-gray-500"
                >
                  {label} —{" "}
                  <span className="font-bold">
                    ${bestSellingChartData.datasets[0].data[index]} Sales
                  </span>
                </div>
              ))}
            </div>
            <div className="mt-4 flex justify-center">
              <div className="w-24 h-24">
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
      </div>

      {/* Bought Bundles List */}
      <div className="p-8 bg-white">
        <h2 className="text-xl font-semibold mb-6 text-black">
          Bought Bundles
        </h2>
        <div className="space-y-6">
          {[1, 2, 3].map((item, index) => (
            <div
              key={index}
              className="flex flex-col md:flex-row items-start md:items-center justify-between space-y-4 md:space-y-0"
            >
              <div className="flex items-center space-x-4 w-full md:w-auto">
                <img
                  src="/your-image-path.jpg"
                  alt="Casual Men Outfit"
                  className="w-full max-w-[200px] h-auto object-cover rounded-md"
                />
                <div>
                  <h3 className="font-medium text-black">Casual Men Outfit</h3>
                  <p className="text-sm text-[#5C5F6A]">
                    From Collection of Men Outfit in new Bundle
                  </p>
                  <p className="font-semibold mt-1 text-[#1C1D22]">$2400.99</p>
                </div>
              </div>

              <div className="flex items-center space-x-6">
                {index === 0 ? (
                  <span className="bg-green-100 text-green-600 px-4 py-1 rounded-md font-medium text-sm">
                    Shipped
                  </span>
                ) : (
                  <span className="bg-blue-100 text-blue-600 px-4 py-1 rounded-md font-medium text-sm">
                    New order
                  </span>
                )}

                <div className="flex items-center space-x-1">
                  <svg
                    className="w-5 h-5 text-orange-400"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.286 3.967a1 1 0 00.95.69h4.178c.969 0 1.371 1.24.588 1.81l-3.384 2.455a1 1 0 00-.364 1.118l1.287 3.966c.3.921-.755 1.688-1.538 1.118l-3.384-2.455a1 1 0 00-1.175 0l-3.384 2.455c-.783.57-1.838-.197-1.538-1.118l1.287-3.966a1 1 0 00-.364-1.118L2.045 9.394c-.783-.57-.38-1.81.588-1.81h4.178a1 1 0 00.95-.69l1.286-3.967z" />
                  </svg>
                  <span className="font-medium text-gray-700">4.8</span>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

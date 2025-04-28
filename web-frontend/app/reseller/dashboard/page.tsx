"use client";

import { useEffect, useState } from "react";
import { Line, Doughnut } from "react-chartjs-2";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
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

interface User {
  id: string;
  username: string;
  role: string;
  name?: string;
}

export default function DashboardPage() {
  const [totalBought, setTotalBought] = useState(0);
  const [totalSold, setTotalSold] = useState(0);
  const [rating, setRating] = useState(0);
  const [bestSelling, setBestSelling] = useState(0);
  const [user, setUser] = useState<User | null>(null);

  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchUserFromLocalStorage = () => {
      const userData = localStorage.getItem("user");
      if (userData) {
        setUser(JSON.parse(userData));
      }
    };

    const fetchMetrics = async () => {
      try {
        fetchUserFromLocalStorage();

        const token = localStorage.getItem("token");
        if (!token) throw new Error("No token found");

        const response = await fetch("http://localhost:8081/reseller/metrics", {
          headers: { Authorization: `Bearer ${token}` },
        });

        if (!response.ok) throw new Error("Failed to fetch reseller metrics");

        const data = await response.json();
        console.log("📦 Reseller Metrics:", data);

        setTotalBought(data.data.totalBoughtBundles || 0);
setTotalSold(data.data.totalItemsSold || 0);
setRating(data.data.rating || 0);
setBestSelling(data.data.bestSelling || 0);

      } catch (error) {
        console.error("❌ Error fetching metrics:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchMetrics();
  }, []);

  if (loading) {
    return <div className="text-center p-10 text-gray-500">Loading Dashboard...</div>;
  }

  const totalBundlesData = {
    labels: Array.from({ length: 12 }, (_, i) => `Week ${i + 1}`),
    datasets: [
      {
        data: Array(12).fill(totalBought / 12),
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
        data: Array(12).fill(totalSold / 12),
        borderColor: "#00a3a3",
        borderWidth: 2,
        fill: false,
      },
    ],
  };

  const bestSellingChartData = {
    labels: ["Item A", "Item B", "Item C"],
    datasets: [
      {
        data: [100, 70, 50],
        backgroundColor: ["#00a3a3", "#007777", "#008888"],
        hoverBackgroundColor: ["#005555", "#00a3a3", "#007777"],
      },
    ],
  };

  return (
    <div className="space-y-3 p-2">
      {/* Header Section */}
      <div className="flex flex-col md:flex-row md:items-center md:justify-between mb-6 px-2">
        <div className="mb-2 md:mb-0">
          <h1 className="text-2xl font-bold text-[#1C1D22]">Warehouse</h1>
        </div>
        <div className="flex flex-col items-start md:items-end gap-0">
          <h2 className="text-lg font-bold text-[#1C1D22]">Welcome Back!</h2>
          <div className="text-gray-500">
            Hi, {user?.name || user?.username || "Guest"}
          </div>
        </div>
      </div>

      {/* Top Stats */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
        <StatCard title="Bought Bundles" value={totalBought}>
          <Line data={totalBundlesData} options={chartOptions} />
        </StatCard>

        <div className="bg-white p-2 rounded-md shadow flex flex-col justify-between h-full">
          <p className="text-gray-500 text-xs mb-1">Your Rating</p>
          <h2 className="text-2xl font-bold text-right text-[#1C1D22]">
            {rating.toFixed(1)}
          </h2>
        </div>
      </div>

      {/* Middle Section */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
        <StatCard title="Items Sold" value={totalSold}>
          <Line data={bundlesSoldData} options={chartOptions} />
        </StatCard>

        <div className="bg-white rounded-md shadow flex flex-col h-full">
          <div className="p-2 border-b">
            <p className="text-xs text-gray-500">Best Selling</p>
            <h2 className="text-lg font-semibold mt-1 text-[#1C1D22]">
              ${bestSelling.toFixed(2)}
              <span className="text-sm text-gray-500 font-normal"> — Best Item Price</span>
            </h2>
          </div>
          <div className="p-2 flex-1 flex flex-col justify-between">
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
    </div>
  );
}

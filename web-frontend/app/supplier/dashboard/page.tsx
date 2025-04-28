'use client';

import { useEffect, useState } from 'react';
import { Pie } from 'react-chartjs-2';
import {
  Chart as ChartJS,
  ArcElement,
  Tooltip,
  Legend,
} from 'chart.js';
import CountUp from 'react-countup';

ChartJS.register(ArcElement, Tooltip, Legend);

// ---------- Types ----------
interface DashboardResponse {
  totalSales: number;
  rating: number;
  bestSelling: number;
  performanceMetrics: {
    totalBundlesListed: number;
    activeCount: number;
    soldCount: number;
    deactivatedCount: number; // <-- IMPORTANT: make sure you have this in your backend response
  };
}

// ---------- Components ----------
interface StatCardProps {
  title: string;
  value: string | number;
  children?: React.ReactNode;
}

function StatCard({ title, value, children }: StatCardProps) {
  return (
    <div className="bg-white p-5 rounded-lg shadow">
      <p className="text-gray-500 text-base mb-1">{title}</p>
      <h2 className="text-4xl font-semibold text-[#1C1D22]">
        {typeof value === 'number' ? <CountUp end={value} duration={1.5} /> : value}
      </h2>
      {children && <div className="mt-2">{children}</div>}
    </div>
  );
}

// ---------- Main Page ----------
export default function SupplierDashboardPage() {
  const [totalBundles, setTotalBundles] = useState(0);
  const [bundlesSold, setBundlesSold] = useState(0);
  const [rating, setRating] = useState(0);
  const [totalSales, setTotalSales] = useState(0);
  const [bestSelling, setBestSelling] = useState(0);
  const [activeCount, setActiveCount] = useState(0);
  const [deactivatedCount, setDeactivatedCount] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const token = localStorage.getItem('token');
        if (!token) {
          console.error("🚨 No token found in localStorage");
          setError(true);
          return;
        }

        const res = await fetch('http://localhost:8081/supplier/dashboard', {
          headers: { Authorization: `Bearer ${token}` },
        });

        if (!res.ok) throw new Error('Failed to fetch');

        const data: DashboardResponse = await res.json();

        setTotalBundles(data.performanceMetrics.totalBundlesListed);
        setBundlesSold(data.performanceMetrics.soldCount);
        setRating(data.rating);
        setTotalSales(data.totalSales);
        setBestSelling(data.bestSelling);
        setActiveCount(data.performanceMetrics.activeCount);
        setDeactivatedCount(data.performanceMetrics.deactivatedCount || 0);
      } catch (err) {
        console.error("❌ Error loading dashboard:", err);
        setError(true);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  if (loading) {
    return <div className="text-center text-lg mt-10">Loading dashboard...</div>;
  }

  if (error) {
    return <div className="text-center text-lg text-red-500 mt-10">Failed to load dashboard. Please try again.</div>;
  }

  // ---------- Pie Chart Data ----------
  const pieData = {
    labels: ['Available', 'Sold', 'Deactivated'],
    datasets: [
      {
        data: [activeCount, bundlesSold, deactivatedCount],
        backgroundColor: ['#10B981', '#3B82F6', '#9CA3AF'], // Green, Blue, Gray
        hoverOffset: 8,
      },
    ],
  };

  return (
    <div className="space-y-6">
      {/* Top Stats */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <StatCard title="Total Bundles" value={totalBundles} />
        <StatCard title="Bundles Sold" value={bundlesSold} />
        <StatCard title="Your Rating" value={rating.toFixed(1)} />
      </div>

      {/* Extra Stats */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <StatCard title="Total Sales ($)" value={totalSales.toFixed(2)} />
        <StatCard title="Top Sale ($)" value={bestSelling.toFixed(2)} />
      </div>

      {/* Performance Pie Chart */}
      <div className="bg-white p-6 rounded-lg shadow">
        <h2 className="text-2xl font-semibold mb-4">Bundle Status Overview</h2>
        <div className="w-full h-[300px] flex justify-center items-center">
          <div className="w-72 h-72">
            <Pie data={pieData} />
          </div>
        </div>
      </div>
    </div>
  );
}

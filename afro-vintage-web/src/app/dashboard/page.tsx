'use client'
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
  width: '100%',
  height: '80px', // Adjusted height to 80px
};

const generateRandomData = (points, min, max) => {
  return Array.from({ length: points }, () => Math.random() * (max - min) + min);
};

const totalBundlesData = {
  labels: Array.from({ length: 12 }, (_, i) => `Week ${i + 1}`),
  datasets: [
    {
      data: generateRandomData(12, 5, 25),
      borderColor: "#00a3a3", // Updated color
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
      borderColor: "#00a3a3", // Updated color
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
      borderColor: "#00a3a3", // Updated color
      borderWidth: 2,
      fill: false,
    },
  ],
};

const bestSellingChartData = {
  labels: ["Classic Monochrome Tees", "Monochromatic Wardrobe", "Essential Neutrals"],
  datasets: [
    {
      data: [940, 790, 740],
      backgroundColor: ["#00a3a3", "#007777", "#008888"], // Updated colors
      hoverBackgroundColor: ["#005555", "#00a3a36", "#007777"],
    },
  ],
};

const chartOptions = {
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
      tension: 0.4, // Smooth curves for the line chart
    },
  },
};

// Reusable StatCard Component
function StatCard({ title, value, children }) {
  return (
    <div className="bg-white p-4 rounded shadow">
      <p className="text-gray-600 text-sm font-medium">{title}</p>
      <h2 className="text-3xl font-bold text-gray-800">{value}</h2>
      <div className="mt-2">{children}</div>
    </div>
  );
}

export default function DashboardPage() {
  return (
    <div>
      {/* Header */}
      <header className="flex justify-between items-center mb-6">
        <input
          type="text"
          placeholder="Search Bundles"
          className="border rounded px-4 py-2 w-1/3"
        />
        <div className="flex items-center gap-4">
          <div className="relative w-2/4">
            <span className="absolute inset-y-0 left-0 flex items-center pl-3">
              <FaSearch className="w-5 h-5 text-gray-500" />
            </span>
            <input
              type="text"
              placeholder="Search"
              className="border rounded px-4 py-2 pl-10 w-full bg-transparent placeholder-gray-500 text-gray-700"
            />
          </div>
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

      {/* Metrics */}
      <section className="grid grid-cols-3 gap-6 mb-6">
        <StatCard title="Total Bundles" value="24">
          <Line data={totalBundlesData} options={chartOptions} />
        </StatCard>
        <StatCard title="Bundles Sold" value="18">
          <Line data={bundlesSoldData} options={chartOptions} />
        </StatCard>
        <StatCard title="Your Rating" value="4.7">
          <Line data={ratingData} options={chartOptions} />
        </StatCard>
      </section>

      {/* Best Selling */}
      <section className="grid grid-cols-3 gap-6">
        <div className="bg-white p-6 rounded shadow col-span-1">
          <h3 className="text-gray-800 font-bold text-lg mb-1">Best Selling</h3>
          <p className="text-gray-500 text-sm mb-4">THIS MONTH</p>
          <p className="text-gray-800 text-2xl font-bold mb-4">$2,400 <span className="text-gray-500 text-base font-medium">— Total Sales</span></p>
          <ul className="space-y-2">
            <li className="text-gray-800 text-sm font-medium">Classic Monochrome Tees — <span className="font-bold">$940 Sales</span></li>
            <li className="text-gray-800 text-sm font-medium">Blue Wardrobe — <span className="font-bold">$790 Sales</span></li>
            <li className="text-gray-800 text-sm font-medium">Essential Neutrals — <span className="font-bold">$740 Sales</span></li>
          </ul>
          <div className=" flex justify-center items-center" style={{ width: '150px', height: '150px', margin: '10px auto 0 auto' }}>
            <Doughnut 
              data={bestSellingChartData} 
              options={{
                plugins: {
                  legend: { display: false },
                },
                maintainAspectRatio: false,
                cutout: '70%', // Adjusted cutout percentage to reduce thickness
              }} 
            />
          </div>
        </div>

        {/* Bundles Table */}
        <div className="bg-white p-4 rounded shadow col-span-2">
          <div className="flex justify-between items-center mb-4">
            <h3 className="text-gray-800 font-bold">Bundles</h3>
            <button className="text-gray-500 text-sm font-medium bg-gray-100 px-3 py-1 rounded">View All</button>
          </div>
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className="border-b" style={{ borderColor: 'rgba(128, 128, 128, 0.2)' }}>
                <th className="p-2 text-gray-600 font-medium" style={{ color: 'rgba(128, 128, 128, 0.8)' }}>Item</th>
                <th className="p-2 text-gray-600 font-medium" style={{ color: 'rgba(128, 128, 128, 0.8)' }}>Date</th>
                <th className="p-2 text-gray-600 font-medium" style={{ color: 'rgba(128, 128, 128, 0.8)' }}>Type</th>
                <th className="p-2 text-gray-600 font-medium" style={{ color: 'rgba(128, 128, 128, 0.8)' }}>Status</th>
              </tr>
            </thead>
            <tbody className="text-gray-800">
              <tr className="border-b" style={{ borderColor: 'rgba(128, 128, 128, 0.1)' }}>
                <td className="p-2">Mens Black T-Shirts</td>
                <td className="p-2">20 Mar, 2023</td>
                <td className="p-2">Sorted</td>
                <td className="p-2">Available</td>
              </tr>
              <tr className="border-b" style={{ borderColor: 'rgba(128, 128, 128, 0.1)' }}>
                <td className="p-2">Essential Neutrals</td>
                <td className="p-2">19 Mar, 2023</td>
                <td className="p-2">Unsorted</td>
                <td className="p-2">Sold</td>
              </tr>
              <tr className="border-b" style={{ borderColor: 'rgba(128, 128, 128, 0.1)' }}>
                <td className="p-2">Sleek and Cozy Black</td>
                <td className="p-2">7 Feb, 2023</td>
                <td className="p-2">Sorted</td>
                <td className="p-2">Available</td>
              </tr>
              <tr className="border-b" style={{ borderColor: 'rgba(128, 128, 128, 0.1)' }}>
                <td className="p-2">MOCKUP Black</td>
                <td className="p-2">29 Jan, 2023</td>
                <td className="p-2">Unsorted</td>
                <td className="p-2">Sold</td>
              </tr>
              <tr style={{ borderColor: 'rgba(128, 128, 128, 0.1)' }}>
                <td className="p-2">Monochromatic Wardrobe</td>
                <td className="p-2">27 Jan, 2023</td>
                <td className="p-2">Sorted</td>
                <td className="p-2">Available</td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>
    </div>
  );
}
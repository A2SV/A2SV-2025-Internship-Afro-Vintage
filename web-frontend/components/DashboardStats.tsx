import React from 'react';
import { UserRole } from '../config/roles';
import { Line } from 'react-chartjs-2';
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
  BarElement,
} from 'chart.js';

// Register ChartJS components
ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  Title,
  Tooltip,
  Legend
);

interface StatsCardProps {
  title: string;
  value: string | number;
  subtitle: string;
  chart?: number[];
}

const StatsCard: React.FC<StatsCardProps> = ({ title, value, subtitle, chart }) => (
  <div className="bg-white p-6 rounded-lg shadow-sm">
    <div className="mb-4">
      <h3 className="text-gray-500 text-sm uppercase">{title}</h3>
      <div className="flex items-baseline mt-2">
        <p className="text-3xl font-semibold">{value}</p>
      </div>
      <p className="text-gray-600 text-sm mt-1">{subtitle}</p>
    </div>
    {chart && (
      <div className="h-16">
        <Line
          data={{
            labels: Array(chart.length).fill(''),
            datasets: [
              {
                data: chart,
                borderColor: title === 'Active Bundles' ? '#8B4513' : '#4A5568',
                tension: 0.4,
                borderWidth: 2,
                pointRadius: 0,
              },
            ],
          }}
          options={{
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
              legend: { display: false },
            },
            scales: {
              x: { display: false },
              y: { display: false },
            },
          }}
        />
      </div>
    )}
  </div>
);

interface BestSellingItemProps {
  title: string;
  sales: number;
}

const BestSellingSection: React.FC<{ items: BestSellingItemProps[] }> = ({ items }) => (
  <div className="bg-white p-6 rounded-lg shadow-sm">
    <div className="flex justify-between items-center mb-4">
      <h3 className="text-gray-500 text-sm uppercase">Best Selling</h3>
      <span className="text-sm text-gray-500">THIS MONTH</span>
    </div>
    <div className="text-2xl font-semibold mb-4">$2,400</div>
    <div className="space-y-3">
      {items.map((item, index) => (
        <div key={index} className="flex justify-between items-center">
          <span className="text-gray-600">{item.title}</span>
          <span className="text-gray-500">${item.sales} Sales</span>
        </div>
      ))}
    </div>
  </div>
);

interface BundleTableProps {
  bundles: {
    id: number;
    item: string;
    date: string;
    type: string;
    status: string;
    grade?: string;
  }[];
  showGrade?: boolean;
}

const BundleTable: React.FC<BundleTableProps> = ({ bundles, showGrade = false }) => (
  <div className="bg-white rounded-lg shadow-sm">
    <div className="flex justify-between items-center p-6 border-b">
      <h3 className="text-gray-500 text-sm uppercase">Bundles</h3>
      <button className="text-brown-600 text-sm hover:underline">View All</button>
    </div>
    <div className="overflow-x-auto">
      <table className="w-full">
        <thead className="bg-gray-50">
          <tr>
            {showGrade && (
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Bundle ID</th>
            )}
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Item</th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Date</th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Type</th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
            {showGrade && (
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Grade</th>
            )}
          </tr>
        </thead>
        <tbody className="divide-y divide-gray-200">
          {bundles.map((bundle) => (
            <tr key={bundle.id}>
              {showGrade && (
                <td className="px-6 py-4 text-sm text-gray-500">{bundle.id}</td>
              )}
              <td className="px-6 py-4 text-sm text-gray-900">{bundle.item}</td>
              <td className="px-6 py-4 text-sm text-gray-500">{bundle.date}</td>
              <td className="px-6 py-4 text-sm">
                <span className={`px-2 py-1 rounded-full text-xs ${
                  bundle.type === 'Sorted' ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800'
                }`}>
                  {bundle.type}
                </span>
              </td>
              <td className="px-6 py-4 text-sm">
                <span className={`px-2 py-1 rounded-full text-xs ${
                  bundle.status === 'Available' ? 'bg-blue-100 text-blue-800' : 'bg-gray-100 text-gray-800'
                }`}>
                  {bundle.status}
                </span>
              </td>
              {showGrade && bundle.grade && (
                <td className="px-6 py-4 text-sm font-medium">{bundle.grade}</td>
              )}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  </div>
);

interface DashboardStatsProps {
  role: UserRole;
  stats: {
    // Supplier stats
    totalBundles?: number;
    bundlesSold?: number;
    rating?: number;
    // Reseller stats
    activeBundles?: number;
    itemsListed?: number;
    skippedItems?: number;
  };
  chartData: {
    // Supplier charts
    bundlesChart?: number[];
    salesChart?: number[];
    // Reseller charts
    activeBundlesChart?: number[];
    itemsListedChart?: number[];
    skippedItemsChart?: number[];
  };
  bundles: BundleTableProps['bundles'];
  bestSelling?: BestSellingItemProps[];
}

const DashboardStats: React.FC<DashboardStatsProps> = ({
  role,
  stats,
  chartData,
  bundles,
  bestSelling = [],
}) => {
  const isSupplier = role === UserRole.SUPPLIER;

  return (
    <div className="space-y-6">
      {/* Stats Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {isSupplier ? (
          <>
            <StatsCard
              title="Total Bundles"
              value={stats.totalBundles || 0}
              subtitle="THIS MONTH"
              chart={chartData.bundlesChart}
            />
            <StatsCard
              title="Bundles Sold"
              value={stats.bundlesSold || 0}
              subtitle="THIS MONTH"
              chart={chartData.salesChart}
            />
            <StatsCard
              title="Your Rating"
              value={stats.rating?.toFixed(1) || '0.0'}
              subtitle="OVERALL"
            />
          </>
        ) : (
          <>
            <StatsCard
              title="Active Bundles"
              value={stats.activeBundles || 0}
              subtitle="THIS MONTH"
              chart={chartData.activeBundlesChart}
            />
            <StatsCard
              title="Items Listed"
              value={stats.itemsListed || 0}
              subtitle="THIS MONTH"
              chart={chartData.itemsListedChart}
            />
            <StatsCard
              title="Skipped Items"
              value={stats.skippedItems || 0}
              subtitle="THIS MONTH"
              chart={chartData.skippedItemsChart}
            />
          </>
        )}
      </div>

      {/* Content Grid */}
      {isSupplier ? (
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          <BestSellingSection items={bestSelling} />
          <div className="lg:col-span-2">
            <BundleTable bundles={bundles} showGrade={false} />
          </div>
        </div>
      ) : (
        <div>
          <BundleTable bundles={bundles} showGrade={true} />
        </div>
      )}
    </div>
  );
};

export default DashboardStats; 
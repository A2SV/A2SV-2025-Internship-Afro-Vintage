import type { Meta, StoryObj } from '@storybook/react';
import DashboardStats from '../components/DashboardStats';
import { UserRole } from '../config/roles';

const meta = {
  title: 'Components/DashboardStats',
  component: DashboardStats,
  parameters: {
    layout: 'centered',
  },
  tags: ['autodocs'],
} satisfies Meta<typeof DashboardStats>;

export default meta;
type Story = StoryObj<typeof meta>;

const sampleData = {
  stats: {
    activeBundles: 24,
    itemsListed: 18,
    skippedItems: 6,
  },
  chartData: {
    activeBundlesChart: [20, 22, 24, 23, 24, 25],
    itemsListedChart: [15, 16, 17, 18, 17, 18],
    skippedItemsChart: [5, 6, 7, 5, 7, 6],
  },
  bundles: [
    {
      id: 1,
      item: 'Vintage Denim Jacket',
      date: '2024-04-10',
      type: 'SORTED',
      status: 'AVAILABLE',
      grade: 'A',
    },
    {
      id: 2,
      item: 'Retro Sneakers',
      date: '2024-04-09',
      type: 'UNSORTED',
      status: 'SOLD',
      grade: 'B',
    },
  ],
};

export const Reseller: Story = {
  args: {
    role: UserRole.RESELLER,
    ...sampleData,
  },
};

export const Supplier: Story = {
  args: {
    role: UserRole.SUPPLIER,
    stats: {
      totalBundles: 24,
      bundlesSold: 18,
      rating: 4.7,
    },
    chartData: {
      bundlesChart: [20, 22, 24, 23, 24, 25],
      salesChart: [15, 16, 17, 18, 17, 18],
    },
    bundles: sampleData.bundles,
    bestSelling: [
      { title: 'Vintage Denim Jacket', sales: 45 },
      { title: 'Retro Sneakers', sales: 32 },
    ],
  },
}; 
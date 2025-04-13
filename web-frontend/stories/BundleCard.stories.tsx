import type { Meta, StoryObj } from '@storybook/react';
import BundleCard from '../components/BundleCard';
import { Bundle } from '../types/bundle';
import { BundleStatus } from '../config/status';

const meta = {
  title: 'Components/BundleCard',
  component: BundleCard,
  parameters: {
    layout: 'centered',
  },
  tags: ['autodocs'],
} satisfies Meta<typeof BundleCard>;

export default meta;
type Story = StoryObj<typeof meta>;

const sampleBundle: Bundle = {
  id: '1',
  supplierId: '1',
  title: 'Vintage Clothing Bundle',
  description: 'Collection of vintage clothing items',
  price: 199.99,
  status: BundleStatus.AVAILABLE,
  images: ['/images/placeholder.jpg'],
  category: 'Clothing',
  condition: 'Good',
  weight: 2.5,
  dimensions: {
    length: 30,
    width: 20,
    height: 10,
  },
  createdAt: new Date(),
  updatedAt: new Date(),
};

export const Default: Story = {
  args: {
    bundle: sampleBundle,
    sortingType: 'sorted',
    grade: 4.5,
    itemCount: 5,
    totalSold: 10,
  },
}; 
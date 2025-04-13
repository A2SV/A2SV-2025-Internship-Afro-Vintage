import type { Meta, StoryObj } from '@storybook/react';
import ItemCard from '../components/ItemCard';
import { Listing } from '../types/listing';
import { ItemStatus } from '../config/status';

const meta = {
  title: 'Components/ItemCard',
  component: ItemCard,
  parameters: {
    layout: 'centered',
  },
  tags: ['autodocs'],
} satisfies Meta<typeof ItemCard>;

export default meta;
type Story = StoryObj<typeof meta>;

const sampleListing: Listing = {
  id: '1',
  resellerId: '1',
  bundleItemId: '1',
  title: 'Vintage Denim Jacket',
  description: 'Classic denim jacket from the 90s',
  price: 45.99,
  status: ItemStatus.AVAILABLE,
  images: ['/images/placeholder.jpg'],
  category: 'Clothing',
  condition: 'Good',
  brand: 'Levi\'s',
  size: 'M',
  color: 'Blue',
  material: 'Denim',
  createdAt: new Date(),
  updatedAt: new Date(),
};

export const Default: Story = {
  args: {
    listing: sampleListing,
    sortingType: 'sorted',
    grade: 4.5,
    totalSold: 10,
  },
}; 
import type { Meta, StoryObj } from '@storybook/react';
import ItemCard from './ItemCard';

const meta: Meta<typeof ItemCard> = {
  title: 'Marketplace/ItemCard',
  component: ItemCard,
  parameters: {
    layout: 'centered',
  },
  tags: ['autodocs'],
};

export default meta;
type Story = StoryObj<typeof ItemCard>;

export const Default: Story = {
  args: {
    item: {
      id: '1',
      title: 'Nike Sportswear Club Fleece',
      price: 99,
      thumbnailUrl: 'images/item-card-image.png',
      resellerId: 'reseller1',
      resellerName: 'Vintage Finds Co.',
      status: 'available',
      description: 'Classic fleece jacket for everyday wear',
      category: 'Jackets',
      grade: 'A'
    }
  }
};

export const SoldItem: Story = {
  args: {
    item: {
      id: '2',
      title: 'Trail Running Jacket Nike Windrunner',
      price: 99,
      thumbnailUrl: 'images/item-card-image.png',
      resellerId: 'reseller2',
      resellerName: 'Premium Vintage',
      status: 'sold',
      description: 'Lightweight running jacket with wind protection',
      category: 'Jackets',
      grade: 'B'
    }
  }
};

export const LongTitle: Story = {
  args: {
    item: {
      id: '3',
      title: 'Nike Sportswear Club Fleece Limited Edition Winter Collection 2024',
      price: 149,
      thumbnailUrl: 'images/item-card-image.png',
      resellerId: 'reseller3',
      resellerName: 'Classic Styles',
      status: 'available',
      description: 'Limited edition winter collection fleece',
      category: 'Jackets',
      grade: 'A+'
    }
  }
}; 
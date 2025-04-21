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
      condition: 'New',
      rating: 4.8,
      status: 'available'
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
      condition: 'Like New',
      rating: 4.9,
      status: 'sold'
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
      condition: 'New',
      rating: 5.0,
      status: 'available'
    }
  }
}; 
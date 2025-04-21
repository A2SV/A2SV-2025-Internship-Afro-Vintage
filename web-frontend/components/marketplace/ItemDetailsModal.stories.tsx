import type { Meta, StoryObj } from '@storybook/react';
import ItemDetailsModal from './ItemDetailsModal';

const meta: Meta<typeof ItemDetailsModal> = {
  title: 'Components/ItemDetailsModal',
  component: ItemDetailsModal,
  parameters: {
    layout: 'fullscreen',
  },
};

export default meta;
type Story = StoryObj<typeof ItemDetailsModal>;

const sampleItem = {
  id: '1',
  name: 'T-shirt',
  price: 1999.99,
  image: '/images/item-card-image.png',
  description: `• Makanan yang lengkap dan seimbang, dengan di nutrisi penting\n• Mengandung antioksidan (vitamin E dan selenium) untuk sistem kekebalan tubuh yang sehat\n• Mengandung serat untuk memperlancar pencernaan dan meningkatkan kesehatan usus`,
  category: 'Clothing',
  size: 'S',
  grade: 'Like New',
  status: 'available' as const,
};

export const Available: Story = {
  args: {
    item: sampleItem,
    isOpen: true,
    onClose: () => {},
  },
};

export const SoldOut: Story = {
  args: {
    item: {
      ...sampleItem,
      status: 'sold',
    },
    isOpen: true,
    onClose: () => {},
  },
}; 
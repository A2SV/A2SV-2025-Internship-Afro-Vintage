import type { Meta, StoryObj } from '@storybook/react';
import Sidebar from '../components/Sidebar';
import { UserRole } from '../config/roles';

const meta = {
  title: 'Components/Sidebar',
  component: Sidebar,
  parameters: {
    layout: 'fullscreen',
  },
  tags: ['autodocs'],
} satisfies Meta<typeof Sidebar>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Supplier: Story = {
  args: {
    user: {
      id: '1',
      name: 'John Doe',
      role: UserRole.SUPPLIER,
      email: 'john@example.com',
    },
  },
};

export const Reseller: Story = {
  args: {
    user: {
      id: '2',
      name: 'Jane Smith',
      role: UserRole.RESELLER,
      email: 'jane@example.com',
    },
  },
}; 
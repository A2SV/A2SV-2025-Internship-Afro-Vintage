import type { Meta, StoryObj } from '@storybook/react';
import Navbar from '../components/Navbar';
import { UserRole } from '../config/roles';

const meta = {
  title: 'Components/Navbar',
  component: Navbar,
  parameters: {
    layout: 'fullscreen',
  },
  tags: ['autodocs'],
} satisfies Meta<typeof Navbar>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Supplier: Story = {
  args: {
    user: {
      name: "Jake Santiago",
      role: UserRole.SUPPLIER,
      avatar: "/images/avatar.jpg"
    },
    onSearch: (query: string) => console.log('Searching for:', query),
  },
};

export const Reseller: Story = {
  args: {
    user: {
      name: "Sarah Johnson",
      role: UserRole.RESELLER,
      avatar: "/images/avatar.jpg"
    },
    onSearch: (query: string) => console.log('Searching for:', query),
  },
}; 
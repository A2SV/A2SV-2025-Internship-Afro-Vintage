import type { Meta, StoryObj } from '@storybook/react';
import { SessionProvider } from 'next-auth/react';
import { CartProvider } from '@/context/CartContext';
import Navbar from './Navbar';

const NavbarWithProviders = ({ session }: { session: any }) => {
  return (
    <SessionProvider session={session}>
      <CartProvider>
        <div className="min-h-screen">
          <Navbar onFilterClick={() => {}} />
        </div>
      </CartProvider>
    </SessionProvider>
  );
};

const meta: Meta<typeof NavbarWithProviders> = {
  title: 'Layout/Navbar',
  component: NavbarWithProviders,
  parameters: {
    layout: 'fullscreen',
  },
};

export default meta;
type Story = StoryObj<typeof NavbarWithProviders>;

const defaultSession = {
  user: {
    name: 'John Doe',
    email: 'john@example.com',
    image: '/images/avatar.png',
    role: 'Consumer'
  },
  expires: '2024-01-01'
};

export const Default: Story = {
  args: {
    session: defaultSession
  }
};

export const Loading: Story = {
  args: {
    session: null
  }
};

export const MobileMenuOpen: Story = {
  args: {
    session: defaultSession
  },
  parameters: {
    viewport: {
      defaultViewport: 'mobile1'
    }
  }
}; 
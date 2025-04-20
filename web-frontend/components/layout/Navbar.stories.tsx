import type { Meta, StoryObj } from '@storybook/react';
import { SessionProvider } from 'next-auth/react';
import Navbar from './Navbar';

const NavbarWithSession = ({ session }: { session: any }) => {
  return (
    <SessionProvider session={session}>
      <div className="min-h-screen">
        <Navbar />
      </div>
    </SessionProvider>
  );
};

const meta: Meta<typeof NavbarWithSession> = {
  title: 'Layout/Navbar',
  component: NavbarWithSession,
  parameters: {
    layout: 'fullscreen',
  },
};

export default meta;
type Story = StoryObj<typeof NavbarWithSession>;

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
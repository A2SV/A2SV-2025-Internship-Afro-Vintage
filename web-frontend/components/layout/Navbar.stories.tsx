import type { Meta, StoryObj } from '@storybook/react';
import { SessionProvider } from 'next-auth/react';
import Navbar from './Navbar';

const mockSession = {
  user: {
    name: 'John Doe',
    email: 'john@example.com',
    image: '/images/avatar.png',
    role: 'Consumer'
  },
  expires: '2024-01-01'
};

const meta: Meta<typeof Navbar> = {
  title: 'Layout/Navbar',
  component: Navbar,
  parameters: {
    layout: 'fullscreen',
  },
  decorators: [
    (Story, context) => {
      const session = context.parameters.session || mockSession;
      return (
        <SessionProvider session={session}>
          <div className="min-h-screen">
            <Story />
          </div>
        </SessionProvider>
      );
    },
  ],
};

export default meta;
type Story = StoryObj<typeof Navbar>;

export const Default: Story = {
  parameters: {
    session: mockSession
  }
};

export const Loading: Story = {
  parameters: {
    session: null
  }
};

export const MobileMenuOpen: Story = {
  parameters: {
    viewport: {
      defaultViewport: 'mobile1',
    },
    session: mockSession
  }
}; 
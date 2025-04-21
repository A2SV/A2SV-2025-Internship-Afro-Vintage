import type { Meta, StoryObj } from '@storybook/react';
import { SessionProvider } from 'next-auth/react';
import MarketplacePage from './page';

const MarketplaceWithSession = ({ session }: { session: any }) => {
  return (
    <SessionProvider session={session}>
      <MarketplacePage />
    </SessionProvider>
  );
};

const meta: Meta<typeof MarketplaceWithSession> = {
  title: 'Consumer/MarketplacePage',
  component: MarketplaceWithSession,
  parameters: {
    layout: 'fullscreen',
  },
};

export default meta;
type Story = StoryObj<typeof MarketplaceWithSession>;

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

const mockItems = [
  {
    id: '1',
    title: 'Nike Sportswear Club Fleece',
    price: 99,
    thumbnailUrl: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/3df241d1-ede8-47a5-9434-c72607f0c0b1/sportswear-club-fleece-crew-KflRdQ.png',
    condition: 'New',
    rating: 4.8,
    status: 'available'
  },
  {
    id: '2',
    title: 'Trail Running Jacket Nike Windrunner',
    price: 99,
    thumbnailUrl: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/bdf4c1b0-54c0-4c04-b2ba-7c0d29d7a67a/windrunner-jacket-K5Hhrd.png',
    condition: 'Like New',
    rating: 4.9,
    status: 'available'
  },
  {
    id: '3',
    title: 'Nike Sportswear Club Fleece Limited Edition',
    price: 149,
    thumbnailUrl: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/3df241d1-ede8-47a5-9434-c72607f0c0b1/sportswear-club-fleece-crew-KflRdQ.png',
    condition: 'New',
    rating: 5.0,
    status: 'sold'
  }
];

export const DefaultStory: Story = {
  parameters: {
    msw: {
      handlers: [
        {
          url: '/api/marketplace/items*',
          method: 'GET',
          status: 200,
          response: {
            items: mockItems,
            total: mockItems.length,
            page: 1,
            limit: 12
          }
        }
      ]
    }
  }
};

export const LoadingStory: Story = {
  parameters: {
    msw: {
      handlers: [
        {
          url: '/api/marketplace/items*',
          method: 'GET',
          status: 200,
          delay: 2000,
          response: {
            items: mockItems,
            total: mockItems.length,
            page: 1,
            limit: 12
          }
        }
      ]
    }
  }
};

export const ErrorStory: Story = {
  parameters: {
    msw: {
      handlers: [
        {
          url: '/api/marketplace/items*',
          method: 'GET',
          status: 500,
          response: {
            message: 'Internal Server Error'
          }
        }
      ]
    }
  }
}; 
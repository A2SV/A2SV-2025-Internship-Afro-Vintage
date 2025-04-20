import type { Meta, StoryObj } from '@storybook/react';
import MarketplacePage from './page';

const meta: Meta<typeof MarketplacePage> = {
  title: 'Pages/MarketplacePage',
  component: MarketplacePage,
  parameters: {
    layout: 'fullscreen',
  },
  decorators: [
    (Story) => (
      <div className="min-h-screen bg-gray-50">
        <Story />
      </div>
    ),
  ],
};

export default meta;
type Story = StoryObj<typeof MarketplacePage>;

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

export const Default: Story = {
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

export const Loading: Story = {
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

export const Error: Story = {
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
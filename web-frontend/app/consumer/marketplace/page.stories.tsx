import type { Meta, StoryObj } from '@storybook/react';
import { SessionProvider } from 'next-auth/react';
import MarketplacePage from './page';
import { ItemPreview } from '@/types/marketplace';

// Sample data for stories
const sampleItems: ItemPreview[] = [
  {
    id: '1',
    title: 'Vintage African Print Dress',
    price: 129.99,
    thumbnailUrl: '/images/item-card-image.png',
    rating: 4.5,
    description: 'Beautiful handmade dress with traditional African prints',
    category: 'Clothing',
    size: 'M',
    grade: 'Like New'
  },
  {
    id: '2',
    title: 'Handwoven Basket',
    price: 49.99,
    thumbnailUrl: '/images/item-card-image2.png',
    rating: 4.5,
    description: 'Traditional handwoven basket perfect for storage or decoration',
    category: 'Home & Living',
    size: 'One Size',
    grade: 'New'
  },
  {
    id: '3',
    title: 'Beaded Necklace',
    price: 79.99,
    thumbnailUrl: '/images/item-card-image.png',
    rating: 4.5,
    description: 'Stunning beaded necklace made with authentic African beads',
    category: 'Jewelry',
    size: 'One Size',
    grade: 'Good'
  },
  {
    id: '4',
    title: 'Wooden Sculpture',
    price: 199.99,
    thumbnailUrl: '/images/item-card-image2.png',
    rating: 4.5,
    description: 'Hand-carved wooden sculpture representing African heritage',
    category: 'Art',
    size: 'One Size',
    grade: 'Like New'
  }
];

const MarketplaceWithSession = ({ 
  session,
  initialItems = [],
  initialLoading = false,
  initialFilters = {
    search: '',
    category: [],
    size: [],
    priceRange: {
      min: 0,
      max: 1000,
    },
    grade: [],
  }
}: { 
  session: any;
  initialItems?: ItemPreview[];
  initialLoading?: boolean;
  initialFilters?: {
    search: string;
    category: string[];
    size: string[];
    priceRange: {
      min: number;
      max: number;
    };
    grade: string[];
  };
}) => {
  return (
    <SessionProvider session={session}>
      <MarketplacePage 
        initialItems={initialItems}
        initialLoading={initialLoading}
        initialFilters={initialFilters}
      />
    </SessionProvider>
  );
};

const meta: Meta<typeof MarketplaceWithSession> = {
  title: 'Pages/Marketplace',
  component: MarketplaceWithSession,
  parameters: {
    layout: 'fullscreen',
  },
};

export default meta;
type Story = StoryObj<typeof MarketplaceWithSession>;

// Default story with items
export const WithItems: Story = {
  args: {
    session: {
      user: {
        name: 'John Doe',
        email: 'john@example.com',
        role: 'consumer',
        image: '/images/avatar.png',
      },
    },
    initialItems: sampleItems,
    initialLoading: false,
  },
};

// Loading state
export const Loading: Story = {
  args: {
    session: {
      user: {
        name: 'John Doe',
        email: 'john@example.com',
        role: 'consumer',
        image: '/images/avatar.png',
      },
    },
    initialItems: [],
    initialLoading: true,
  },
};

// No items found state
export const NoItems: Story = {
  args: {
    session: {
      user: {
        name: 'John Doe',
        email: 'john@example.com',
        role: 'consumer',
        image: '/images/avatar.png',
      },
    },
    initialItems: [],
    initialLoading: false,
  },
};

// With filters applied
export const WithFilters: Story = {
  args: {
    session: {
      user: {
        name: 'Jake Santiago',
        email: 'jake@example.com',
        role: 'Consumer',
        image: '/images/avatar.png',
      },
    },
    initialItems: sampleItems.filter(item => 
      item.category === 'Clothing'
    ),
    initialLoading: false,
    initialFilters: {
      search: '',
      category: ['#2025', 'Hoodie', 'Men'],
      size: [],
      priceRange: {
        min: 0,
        max: 1000,
      },
      grade: [],
    },
  },
}; 
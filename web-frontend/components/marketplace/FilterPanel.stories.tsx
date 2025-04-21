import type { Meta, StoryObj } from '@storybook/react';
import FilterPanel from './FilterPanel';

const meta: Meta<typeof FilterPanel> = {
  title: 'Marketplace/FilterPanel',
  component: FilterPanel,
  parameters: {
    layout: 'centered',
  },
};

export default meta;
type Story = StoryObj<typeof FilterPanel>;

export const Default: Story = {
  args: {
    onFilterChange: (filters) => console.log('Filters changed:', filters),
  },
};

export const WithActiveFilters: Story = {
  args: {
    onFilterChange: (filters) => console.log('Filters changed:', filters),
  },
  parameters: {
    initialFilters: {
      search: 'jacket',
      category: ['Jackets'],
      size: ['M', 'L'],
      priceRange: {
        min: 50,
        max: 200,
      },
      grade: ['Good', 'Like New'],
    },
  },
}; 
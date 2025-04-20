import type { Meta, StoryObj } from '@storybook/react';
import Sidebar from './Sidebar';

const meta: Meta<typeof Sidebar> = {
  title: 'Layout/Sidebar',
  component: Sidebar,
  parameters: {
    layout: 'fullscreen',
  },
  tags: ['autodocs'],
};

export default meta;
type Story = StoryObj<typeof Sidebar>;

export const Default: Story = {
  render: () => <Sidebar />,
};

export const Collapsed: Story = {
  render: () => {
    // This is a workaround to show the collapsed state
    return (
      <div className="h-screen">
        <Sidebar />
      </div>
    );
  },
}; 
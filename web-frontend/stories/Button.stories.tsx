import type { Meta, StoryObj } from '@storybook/react';
import { Button } from '../components/ui/Button';

const meta: Meta<typeof Button> = {
  title: 'Components/Button',
  component: Button,
  parameters: {
    layout: 'centered',
  },
  tags: ['autodocs'],
};

export default meta;
type Story = StoryObj<typeof Button>;

export const Primary: Story = {
  args: {
    children: 'Sign up',
    variant: 'primary',
  },
};

export const Secondary: Story = {
  args: {
    children: 'Cancel',
    variant: 'secondary',
  },
};

export const Outline: Story = {
  args: {
    children: 'Learn More',
    variant: 'outline',
  },
};

export const Loading: Story = {
  args: {
    children: 'Processing...',
    isLoading: true,
  },
};

export const Large: Story = {
  args: {
    children: 'Register',
    size: 'lg',
  },
};

export const Small: Story = {
  args: {
    children: 'Skip',
    size: 'sm',
  },
};

export const FullWidth: Story = {
  args: {
    children: 'Submit',
    fullWidth: true,
  },
}; 
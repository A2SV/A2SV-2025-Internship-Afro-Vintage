import React from 'react';
import type { Preview } from "@storybook/react";
import { SessionProvider } from 'next-auth/react';
import { CartProvider } from '../context/CartContext';
import '../app/globals.css';

const preview: Preview = {
  parameters: {
    actions: { argTypesRegex: "^on[A-Z].*" },
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/,
      },
    },
  },
  decorators: [
    (Story, context) => {
      const mockSession = context.parameters.session || {
        user: {
          name: 'John Doe',
          email: 'john@example.com',
          image: '/images/avatar.png',
          role: 'Consumer'
        },
        expires: '2024-01-01'
      };

      return (
        <SessionProvider session={mockSession}>
          <CartProvider>
            <Story />
          </CartProvider>
        </SessionProvider>
      );
    },
  ],
};

export default preview; 
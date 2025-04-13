import React from 'react';
import { NextRouter } from 'next/router';
import { RouterContext } from 'next/dist/shared/lib/router-context.shared-runtime';
import { AuthProvider } from '../contexts/AuthContext';

const mockRouter: Partial<NextRouter> = {
  basePath: '',
  pathname: '/',
  route: '/',
  asPath: '/',
  query: {},
  push: async () => true,
  replace: async () => true,
  reload: () => {},
  back: () => {},
  prefetch: async () => {},
  beforePopState: () => {},
  events: {
    on: () => {},
    off: () => {},
    emit: () => {},
  },
  isFallback: false,
  isLocaleDomain: false,
  isReady: true,
  isPreview: false,
};

export const withRouter = (Story: React.ComponentType) => (
  <RouterContext.Provider value={mockRouter as NextRouter}>
    <AuthProvider>
      <Story />
    </AuthProvider>
  </RouterContext.Provider>
); 
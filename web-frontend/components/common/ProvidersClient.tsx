'use client';

import { Providers } from '@/components/providers/Providers';

export default function ProvidersClient({ children }: { children: React.ReactNode }) {
  return <Providers>{children}</Providers>;
}

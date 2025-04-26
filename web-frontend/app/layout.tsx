import { Inter } from 'next/font/google';
import './globals.css';
import { Providers } from '@/components/providers/Providers';

const inter = Inter({ subsets: ['latin'] });

export const metadata = {
  title: 'Afro Vintage',
  description: 'Your marketplace for authentic African vintage items',
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <Providers>
          {children} {/* Don't wrap with ClientLayout here */}
        </Providers>
      </body>
    </html>
  );
}

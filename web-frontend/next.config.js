/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  images: {
    domains: ['localhost', 'cdn.afro.vintage', 'www.ever-pretty.com', 'a2sv-2025-internship-afro-vintage.onrender.com'],
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'cdn.afro.vintage',
        port: '',
        pathname: '/items/**',
      },
      {
        protocol: 'https',
        hostname: 'www.ever-pretty.com',
        port: '',
        pathname: '/cdn/shop/products/**',
      },
      {
        protocol: 'https',
        hostname: 'a2sv-2025-internship-afro-vintage.onrender.com',
        port: '',
        pathname: '/**',
      },
    ],
  }
}

module.exports = nextConfig 
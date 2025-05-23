# Afro-Vintage Web Frontend

A modern e-commerce platform for vintage African clothing and accessories.

## Features

- 🛍️ Marketplace for vintage African items
- 👥 Multi-role system (Admin, Supplier, Reseller, Consumer)
- 🔐 Secure authentication
- 📱 Responsive design
- 🎨 Modern UI with Tailwind CSS
- 📊 Dashboard for suppliers and resellers
- 🛒 Shopping cart functionality
- 📦 Order management system

## Tech Stack

- Next.js 14
- TypeScript
- Tailwind CSS
- Redux Toolkit
- NextAuth.js
- Chart.js
- Storybook

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   npm install
   ```
3. Configure environment variables in `config/.env`
4. Run the development server:
   ```bash
   npm run dev
   ```
5. Open [http://localhost:3000](http://localhost:3000) in your browser

## Development

- Run Storybook:
  ```bash
  npm run storybook
  ```
- Run tests:
  ```bash
  npm run test
  ```
- Build for production:
  ```bash
  npm run build
  ```

## Project Structure

```
web-frontend/
├── app/                    # Next.js app directory
│   ├── (auth)/            # Authentication routes
│   ├── (landing)/         # Public landing pages
│   ├── dashboard/         # Dashboard layout
│   ├── supplier/          # Supplier routes
│   ├── reseller/          # Reseller routes
│   └── consumer/          # Consumer routes
├── components/            # Reusable components
├── config/               # Configuration files
│   ├── .env             # Environment variables
│   └── site.ts          # Site configuration
├── context/             # React contexts
├── features/            # Redux slices
├── lib/                 # Utilities and helpers
├── store/              # Redux store
├── types/              # TypeScript types
└── styles/             # Global styles
```
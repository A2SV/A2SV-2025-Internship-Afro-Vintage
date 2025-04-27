import { ReactElement } from 'react'
import { render, RenderOptions } from '@testing-library/react'
import { CartProvider } from '@/context/CartContext'

// Mock data
export const mockProduct = {
  id: 1,
  name: 'Test Product',
  description: 'Test Description',
  price: 99.99,
  image: '/test-image.jpg',
  category: 'Test Category',
  stock: 10
}

export const mockUser = {
  id: 1,
  name: 'Test User',
  email: 'test@example.com',
  role: 'consumer'
}

export const mockOrder = {
  id: 1,
  status: 'pending',
  total: 99.99,
  createdAt: '2024-03-20T10:00:00Z',
  items: [
    { id: 1, name: 'Product 1', quantity: 2, price: 49.99 }
  ]
}

// Custom render function with providers
const customRender = (
  ui: ReactElement,
  options?: Omit<RenderOptions, 'wrapper'>
) => {
  return render(ui, {
    wrapper: ({ children }) => (
        <CartProvider>
          {children}
        </CartProvider>
    ),
    ...options,
  })
}

// Re-export everything
export * from '@testing-library/react'
export { customRender as render } 
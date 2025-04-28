import { render, screen, fireEvent, waitFor } from '@testing-library/react'
import { CartProvider, useCart } from '@/context/CartContext'
import { Item } from '@/types/marketplace'
import { vi } from 'vitest'

// Mock the cart API
vi.mock('@/lib/api/cart', () => ({
  cartApi: {
    getCartItems: vi.fn().mockResolvedValue([]),
    addToCart: vi.fn().mockResolvedValue({ success: true, message: 'Item added to cart' }),
    removeFromCart: vi.fn().mockResolvedValue({ success: true, message: 'Item removed from cart' }),
    checkout: vi.fn().mockResolvedValue({ success: true, message: 'Checkout successful' })
  }
}))

// Test component that uses the cart context
const TestComponent = () => {
  const { items, addToCart, removeFromCart, isInCart, checkout, loading } = useCart()
  
  return (
    <div>
      <div data-testid="cart-count">{items.length}</div>
      <div data-testid="loading-status">{loading ? 'Loading' : 'Not Loading'}</div>
      <button onClick={() => addToCart({ id: '1', name: 'Test Item', price: 10 } as Item)}>
        Add Item
      </button>
      <button onClick={() => removeFromCart('1')}>Remove Item</button>
      <button onClick={() => checkout()}>Checkout</button>
      <div data-testid="item-status">
        {isInCart('1') ? 'In Cart' : 'Not In Cart'}
      </div>
    </div>
  )
}

describe('CartContext', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('provides cart context to children', async () => {
    render(
      <CartProvider>
        <TestComponent />
      </CartProvider>
    )
    
    await waitFor(() => {
      expect(screen.getByTestId('cart-count')).toHaveTextContent('0')
      expect(screen.getByTestId('loading-status')).toHaveTextContent('Loading')
    })
  })

  it('adds items to cart', async () => {
    render(
      <CartProvider>
        <TestComponent />
      </CartProvider>
    )
    
    fireEvent.click(screen.getByText('Add Item'))
    
    await waitFor(() => {
      expect(screen.getByTestId('cart-count')).toHaveTextContent('1')
      expect(screen.getByTestId('item-status')).toHaveTextContent('In Cart')
    })
  })

  it('removes items from cart', async () => {
    render(
      <CartProvider>
        <TestComponent />
      </CartProvider>
    )
    
    // Add an item first
    fireEvent.click(screen.getByText('Add Item'))
    await waitFor(() => {
      expect(screen.getByTestId('cart-count')).toHaveTextContent('1')
    })
    
    // Remove the item
    fireEvent.click(screen.getByText('Remove Item'))
    await waitFor(() => {
      expect(screen.getByTestId('cart-count')).toHaveTextContent('0')
      expect(screen.getByTestId('item-status')).toHaveTextContent('Not In Cart')
    })
  })
}) 
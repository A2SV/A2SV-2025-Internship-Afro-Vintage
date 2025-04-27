import { render, screen, fireEvent, waitFor } from '@testing-library/react'
import ItemCard from '@/components/consumer/marketplace/ItemCard'
import { CartProvider } from '@/context/CartContext'
import { vi } from 'vitest'
import { ItemPreview } from '@/types/marketplace'

// Mock next/navigation
vi.mock('next/navigation', () => ({
  useRouter: () => ({
    push: vi.fn()
  })
}))

// Mock cart API
vi.mock('@/lib/api/cart', () => ({
  cartApi: {
    addToCart: vi.fn().mockResolvedValue({ success: true, message: 'Item added to cart' })
  }
}))

// Mock useResellerRatings hook
vi.mock('@/hooks/useResellerRatings', () => ({
  useResellerRatings: () => ({
    ratings: [],
    loading: false
  })
}))

const mockItem: ItemPreview = {
  id: '1',
  title: 'Test Item',
  description: 'Test Description',
  price: 99.99,
  thumbnailUrl: '/test-image.jpg',
  category: 'Test Category',
  resellerId: 'reseller1',
  resellerName: 'Test Reseller',
  status: 'available',
  grade: 'A',
  rating: 4.5
}

describe('ItemCard', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

//   it('renders item information correctly', () => {
//     render(
//       <CartProvider>
//         <ItemCard item={mockItem} />
//       </CartProvider>
//     )
    
//     expect(screen.getByText(mockItem.title)).toBeInTheDocument()
//     expect(screen.getByText(`$${mockItem.price}`)).toBeInTheDocument()
//     expect(screen.getByText(mockItem.resellerName)).toBeInTheDocument()
//     expect(screen.getByText(mockItem.rating!.toFixed(1))).toBeInTheDocument()
//   })

  it('handles item click', () => {
    const onItemClick = vi.fn()
    
    render(
      <CartProvider>
        <ItemCard item={mockItem} onItemClick={onItemClick} />
      </CartProvider>
    )
    
    fireEvent.click(screen.getByText(mockItem.title))
    expect(onItemClick).toHaveBeenCalledWith(mockItem)
  })

  it('displays item image with correct alt text', () => {
    render(
      <CartProvider>
        <ItemCard item={mockItem} />
      </CartProvider>
    )
    
    const image = screen.getByAltText(mockItem.title)
    expect(image).toBeInTheDocument()
    expect(image).toHaveAttribute('src', mockItem.thumbnailUrl)
  })

  it('shows cart button with correct state', () => {
    render(
      <CartProvider>
        <ItemCard item={mockItem} />
      </CartProvider>
    )
    
    const cartButton = screen.getByLabelText('Add to cart')
    expect(cartButton).toBeInTheDocument()
  })
}) 
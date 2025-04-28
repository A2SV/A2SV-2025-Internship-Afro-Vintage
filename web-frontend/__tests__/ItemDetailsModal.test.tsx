import { render, screen, fireEvent } from '@testing-library/react'
import ItemDetailsModal from '@/components/consumer/marketplace/ItemDetailsModal'
import { CartProvider } from '@/context/CartContext'
import { vi } from 'vitest'

// Mock next/image
vi.mock('next/image', () => ({
  __esModule: true,
  default: (props: any) => {
    // eslint-disable-next-line @next/next/no-img-element
    return <img {...props} />
  },
}))

const mockItem = {
  id: '1',
  name: 'Test Item',
  price: 99.99,
  image: '/test-image.jpg',
  description: 'Test Description',
  category: 'Test Category',
  grade: 'A',
  status: 'available' as const,
  seller_id: 'seller1',
  rating: 4.5,
  resellerName: 'Test Reseller'
}

describe('ItemDetailsModal', () => {
  const mockOnClose = vi.fn()

  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('renders item details correctly', () => {
    render(
      <CartProvider>
        <ItemDetailsModal
          item={mockItem}
          isOpen={true}
          onClose={mockOnClose}
        />
      </CartProvider>
    )
    
    expect(screen.getByText(mockItem.name)).toBeInTheDocument()
    expect(screen.getByText(`$${mockItem.price}`)).toBeInTheDocument()
    expect(screen.getByText(mockItem.description)).toBeInTheDocument()
    expect(screen.getByText('Size')).toBeInTheDocument()
    expect(screen.getByText('Description:')).toBeInTheDocument()
  })

  it('calls onClose when close button is clicked', () => {
    render(
      <CartProvider>
        <ItemDetailsModal
          item={mockItem}
          isOpen={true}
          onClose={mockOnClose}
        />
      </CartProvider>
    )
    
    const closeButton = screen.getByRole('button', { name: /close/i })
    fireEvent.click(closeButton)
    
    expect(mockOnClose).toHaveBeenCalled()
  })

  it('does not render when isOpen is false', () => {
    render(
      <CartProvider>
        <ItemDetailsModal
          item={mockItem}
          isOpen={false}
          onClose={mockOnClose}
        />
      </CartProvider>
    )
    
    expect(screen.queryByText(mockItem.name)).not.toBeInTheDocument()
  })

  it('displays correct image with alt text', () => {
    render(
      <CartProvider>
        <ItemDetailsModal
          item={mockItem}
          isOpen={true}
          onClose={mockOnClose}
        />
      </CartProvider>
    )
    
    const itemImage = screen.getByRole('img', { name: mockItem.name })
    expect(itemImage).toHaveAttribute('src', mockItem.image)
    expect(itemImage).toHaveAttribute('alt', mockItem.name)
  })
}) 
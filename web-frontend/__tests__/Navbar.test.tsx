import { render, screen, fireEvent, waitFor } from '@testing-library/react'
import Navbar from '@/components/common/Navbar'
import { CartProvider } from '@/context/CartContext'
import { vi } from 'vitest'

// Mock next/navigation
vi.mock('next/navigation', () => ({
  useRouter: () => ({
    push: vi.fn()
  })
}))

// Mock next/image
vi.mock('next/image', () => ({
  __esModule: true,
  default: (props: any) => {
    // eslint-disable-next-line @next/next/no-img-element
    return <img {...props} />
  },
}))

describe('Navbar', () => {
  beforeEach(() => {
    vi.clearAllMocks()
    localStorage.clear()
  })

  // it('renders search input and cart button', () => {
  //   render(
  //     <CartProvider>
  //       <Navbar />
  //     </CartProvider>
  //   )
    
  //   expect(screen.getByPlaceholderText('Search Bundles')).toBeInTheDocument()
  //   expect(screen.getByRole('button', { name: /cart/i })).toBeInTheDocument()
  // })

  // it('shows filter button when onFilterClick prop is provided', () => {
  //   const onFilterClick = vi.fn()
  //   render(
  //     <CartProvider>
  //       <Navbar onFilterClick={onFilterClick} />
  //     </CartProvider>
  //   )
    
  //   const filterButton = screen.getByRole('button', { name: /filter/i })
  //   expect(filterButton).toBeInTheDocument()
    
  //   fireEvent.click(filterButton)
  //   expect(onFilterClick).toHaveBeenCalled()
  // })

  // it('displays user information when logged in', () => {
  //   const mockUser = {
  //     id: '1',
  //     username: 'testuser',
  //     email: 'test@example.com',
  //     role: 'consumer'
  //   }
  //   localStorage.setItem('user', JSON.stringify(mockUser))
    
  //   render(
  //     <CartProvider>
  //       <Navbar />
  //     </CartProvider>
  //   )
    
  //   expect(screen.getByText('testuser')).toBeInTheDocument()
  //   expect(screen.getByText('consumer')).toBeInTheDocument()
  // })

  it('shows profile menu when profile button is clicked', () => {
    render(
      <CartProvider>
        <Navbar />
      </CartProvider>
    )
    
    const profileButton = screen.getByRole('button', { name: /profile/i })
    fireEvent.click(profileButton)
    
    expect(screen.getByText('Profile Settings')).toBeInTheDocument()
    expect(screen.getByText('Sign Out')).toBeInTheDocument()
  })

  // it('handles sign out correctly', () => {
  //   const mockUser = {
  //     id: '1',
  //     username: 'testuser',
  //     email: 'test@example.com',
  //     role: 'consumer'
  //   }
  //   localStorage.setItem('user', JSON.stringify(mockUser))
  //   localStorage.setItem('token', 'test-token')
    
  //   render(
  //     <CartProvider>
  //       <Navbar />
  //     </CartProvider>
  //   )
    
  //   const profileButton = screen.getByRole('button', { name: /profile/i })
  //   fireEvent.click(profileButton)
    
  //   const signOutButton = screen.getByText('Sign Out')
  //   fireEvent.click(signOutButton)
    
  //   expect(localStorage.getItem('user')).toBeNull()
  //   expect(localStorage.getItem('token')).toBeNull()
  // })

  // it('handles search submission', () => {
  //   const mockDispatchEvent = vi.fn()
  //   window.dispatchEvent = mockDispatchEvent
    
  //   render(
  //     <CartProvider>
  //       <Navbar />
  //     </CartProvider>
  //   )
    
  //   const searchInput = screen.getByPlaceholderText('Search Bundles')
  //   fireEvent.change(searchInput, { target: { value: 'test search' } })
    
  //   const form = searchInput.closest('form')
  //   fireEvent.submit(form!)
    
  //   expect(mockDispatchEvent).toHaveBeenCalled()
  // })
}) 
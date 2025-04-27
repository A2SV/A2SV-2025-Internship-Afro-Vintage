import { render, screen, fireEvent, waitFor } from '@testing-library/react'
import LoginForm from '@/components/auth/LoginForm'
import { authApi } from '@/lib/api/auth'
import { vi } from 'vitest'

// Mock next/navigation
vi.mock('next/navigation', () => ({
  useRouter: () => ({
    push: vi.fn()
  }),
  useSearchParams: () => ({
    get: vi.fn()
  })
}))

// Mock auth API
vi.mock('@/lib/api/auth', () => ({
  authApi: {
    login: vi.fn()
  }
}))

describe('LoginForm', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('renders login form with all fields', () => {
    render(<LoginForm />)
    
    expect(screen.getByPlaceholderText('Username')).toBeInTheDocument()
    expect(screen.getByPlaceholderText('Password')).toBeInTheDocument()
    expect(screen.getByRole('button', { name: /sign in/i })).toBeInTheDocument()
  })

  it('handles form submission correctly', async () => {
    const mockResponse = {
      token: 'test-token',
      user: {
        role: 'consumer'
      }
    }
    ;(authApi.login as any).mockResolvedValueOnce(mockResponse)

    render(<LoginForm />)
    
    // Fill in the form
    fireEvent.change(screen.getByPlaceholderText('Username'), {
      target: { value: 'testuser' }
    })
    fireEvent.change(screen.getByPlaceholderText('Password'), {
      target: { value: 'password123' }
    })
    
    // Submit the form
    fireEvent.click(screen.getByRole('button', { name: /sign in/i }))
    
    await waitFor(() => {
      expect(authApi.login).toHaveBeenCalledWith({
        username: 'testuser',
        password: 'password123'
      })
    })
  })

  it('displays loading state during submission', async () => {
    ;(authApi.login as any).mockImplementation(() => 
      new Promise(resolve => setTimeout(resolve, 100))
    )
    
    render(<LoginForm />)
    
    fireEvent.change(screen.getByPlaceholderText('Username'), {
      target: { value: 'testuser' }
    })
    fireEvent.change(screen.getByPlaceholderText('Password'), {
      target: { value: 'password123' }
    })
    
    fireEvent.click(screen.getByRole('button', { name: /sign in/i }))
    
    expect(screen.getByText('Please wait...')).toBeInTheDocument()
  })

  it('displays error message when login fails', async () => {
    ;(authApi.login as any).mockRejectedValueOnce(new Error('Invalid credentials'))
    
    render(<LoginForm />)
    
    fireEvent.change(screen.getByPlaceholderText('Username'), {
      target: { value: 'testuser' }
    })
    fireEvent.change(screen.getByPlaceholderText('Password'), {
      target: { value: 'password123' }
    })
    
    fireEvent.click(screen.getByRole('button', { name: /sign in/i }))
    
    await waitFor(() => {
      expect(screen.getByText('Invalid username or password')).toBeInTheDocument()
    })
  })

  it('validates required fields', async () => {
    render(<LoginForm />)
    
    // Submit without filling fields
    fireEvent.click(screen.getByRole('button', { name: /sign in/i }))
    
    await waitFor(() => {
      expect(screen.getByPlaceholderText('Username')).toBeInvalid()
      expect(screen.getByPlaceholderText('Password')).toBeInvalid()
    })
  })

}) 
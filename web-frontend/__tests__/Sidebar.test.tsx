import { render, screen } from '@testing-library/react'
import Sidebar from '@/components/common/Sidebar'
import { vi } from 'vitest'

// Mock next/navigation
vi.mock('next/navigation', () => ({
  usePathname: () => '/consumer/marketplace'
}))

// Mock next/image
vi.mock('next/image', () => ({
  __esModule: true,
  default: (props: any) => {
    // eslint-disable-next-line @next/next/no-img-element
    return <img {...props} />
  },
}))

describe('Sidebar', () => {
  beforeEach(() => {
    vi.clearAllMocks()
    localStorage.clear()
  })

  it('renders navigation items', () => {
    render(<Sidebar />)
    
    expect(screen.getByText('Marketplace')).toBeInTheDocument()
    expect(screen.getByText('Orders')).toBeInTheDocument()
    expect(screen.getByText('Settings')).toBeInTheDocument()
  })
}) 
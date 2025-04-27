import { render, screen, fireEvent } from '@testing-library/react'
import FilterPanel from '@/components/consumer/marketplace/FilterPanel'
import { vi } from 'vitest'

describe('FilterPanel', () => {
  const mockOnFilterChange = vi.fn()
  const mockOnClearAll = vi.fn()

  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('renders filter panel with all filter options', () => {
    render(
      <FilterPanel 
        onFilterChange={mockOnFilterChange}
        onClearAll={mockOnClearAll}
      />
    )
    
    expect(screen.getByText('Category')).toBeInTheDocument()
    expect(screen.getByText('Price Range')).toBeInTheDocument()
    expect(screen.getByText('Size')).toBeInTheDocument()
    expect(screen.getByText('Grade')).toBeInTheDocument()
  })

  it('calls onFilterChange when a category is selected', () => {
    render(
      <FilterPanel 
        onFilterChange={mockOnFilterChange}
        onClearAll={mockOnClearAll}
      />
    )
    
    const categoryCheckbox = screen.getByLabelText('shirt')
    fireEvent.click(categoryCheckbox)
    
    expect(mockOnFilterChange).toHaveBeenCalledWith(expect.objectContaining({
      category: ['shirt']
    }))
  })

  it('calls onFilterChange when price range is adjusted', () => {
    render(
      <FilterPanel 
        onFilterChange={mockOnFilterChange}
        onClearAll={mockOnClearAll}
      />
    )
    
    const minPriceInput = screen.getByPlaceholderText('Min')
    fireEvent.change(minPriceInput, { target: { value: '50' } })
    
    expect(mockOnFilterChange).toHaveBeenCalledWith(expect.objectContaining({
      priceRange: expect.objectContaining({
        min: 50
      })
    }))
  })

  it('calls onClearAll when clear all button is clicked', () => {
    render(
      <FilterPanel 
        onFilterChange={mockOnFilterChange}
        onClearAll={mockOnClearAll}
      />
    )
    
    const clearButton = screen.getByText('Clear all')
    fireEvent.click(clearButton)
    
    expect(mockOnClearAll).toHaveBeenCalled()
  })

  it('displays active filters count', () => {
    render(
      <FilterPanel 
        onFilterChange={mockOnFilterChange}
        onClearAll={mockOnClearAll}
      />
    )
    
    // Simulate some filters being selected
    const categoryCheckbox = screen.getByLabelText('shirt')
    fireEvent.click(categoryCheckbox)
    
    const sizeButton = screen.getByText('M')
    fireEvent.click(sizeButton)
    
    const gradeCheckbox = screen.getByLabelText('A')
    fireEvent.click(gradeCheckbox)
    
    const minPriceInput = screen.getByPlaceholderText('Min')
    fireEvent.change(minPriceInput, { target: { value: '50' } })
    
    expect(mockOnFilterChange).toHaveBeenCalledWith(expect.objectContaining({
      category: ['shirt'],
      size: ['M'],
      grade: ['A'],
      priceRange: expect.objectContaining({
        min: 50
      })
    }))
  })
}) 
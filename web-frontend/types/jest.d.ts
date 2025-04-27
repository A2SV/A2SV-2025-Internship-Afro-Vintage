import '@testing-library/jest-dom'

declare global {
  namespace jest {
    interface Matchers<R> {
      toBeInTheDocument(): R
      toBeVisible(): R
      toHaveClass(className: string): R
      toHaveValue(value: string): R
    }
  }
} 
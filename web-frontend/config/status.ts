export enum ItemStatus {
  AVAILABLE = 'available',
  SOLD = 'sold',
  PENDING = 'pending',
  RESERVED = 'reserved',
}

export enum OrderStatus {
  PENDING = 'pending',
  PROCESSING = 'processing',
  SHIPPED = 'shipped',
  DELIVERED = 'delivered',
  CANCELLED = 'cancelled',
}

export enum BundleStatus {
  AVAILABLE = 'available',
  SOLD = 'sold',
  PENDING = 'pending',
  UNPACKING = 'unpacking',
}

export enum UserStatus {
  ACTIVE = 'active',
  INACTIVE = 'inactive',
  SUSPENDED = 'suspended',
} 
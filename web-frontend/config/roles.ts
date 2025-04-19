export type UserRole = 'admin' | 'supplier' | 'reseller' | 'consumer';

export interface RolePermissions {
  canViewDashboard: boolean;
  canManageProducts: boolean;
  canManageOrders: boolean;
  canManageUsers: boolean;
  canViewAnalytics: boolean;
}

export const rolePermissions: Record<UserRole, RolePermissions> = {
  admin: {
    canViewDashboard: true,
    canManageProducts: true,
    canManageOrders: true,
    canManageUsers: true,
    canViewAnalytics: true,
  },
  supplier: {
    canViewDashboard: true,
    canManageProducts: true,
    canManageOrders: true,
    canManageUsers: false,
    canViewAnalytics: true,
  },
  reseller: {
    canViewDashboard: true,
    canManageProducts: false,
    canManageOrders: true,
    canManageUsers: false,
    canViewAnalytics: true,
  },
  consumer: {
    canViewDashboard: true,
    canManageProducts: false,
    canManageOrders: true,
    canManageUsers: false,
    canViewAnalytics: false,
  },
}; 
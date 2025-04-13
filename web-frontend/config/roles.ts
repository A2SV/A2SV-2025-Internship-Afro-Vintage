export enum UserRole {
  ADMIN = 'admin',
  SUPPLIER = 'supplier',
  RESELLER = 'reseller',
  CONSUMER = 'consumer',
}

export const roleRoutes = {
  [UserRole.ADMIN]: ['/dashboard/admin', '/admin/*'],
  [UserRole.SUPPLIER]: ['/dashboard/supplier', '/add-bundle', '/my-bundles'],
  [UserRole.RESELLER]: ['/dashboard/reseller', '/marketplace1', '/add-item', '/my-bundles'],
  [UserRole.CONSUMER]: ['/dashboard/consumer', '/marketplace2', '/cart', '/my-orders'],
};

export const publicRoutes = ['/', '/login', '/register', '/not-authorized']; 
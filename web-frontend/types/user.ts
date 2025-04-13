import { UserRole } from '../config/roles';
import { UserStatus } from '../config/status';

export interface User {
  id: string;
  email: string;
  firstName: string;
  lastName: string;
  role: UserRole;
  status: UserStatus;
  trustScore?: number;
  businessName?: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface UserProfile extends User {
  phoneNumber?: string;
  address?: Address;
  businessName?: string;
  businessType?: string;
  taxId?: string;
}

export interface Address {
  street: string;
  city: string;
  state: string;
  zipCode: string;
  country: string;
}

export interface AuthResponse {
  user: User;
  token: string;
  refreshToken: string;
}

export interface LoginCredentials {
  email: string;
  password: string;
}

export interface RegisterCredentials extends LoginCredentials {
  firstName: string;
  lastName: string;
  role: UserRole;
} 
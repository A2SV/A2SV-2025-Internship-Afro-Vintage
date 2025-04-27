export type UserRole = 'consumer' | 'supplier' | 'reseller' | 'admin';

export interface AuthResponse {
  token: string;
  user?: {
    id: string;
    email: string;
    username: string;
    role: UserRole;
  };
  message?: string;
}

export interface SignupData {
  email: string;
  password: string;
  username: string;
  role: UserRole;
}

export interface LoginData {
  email: string;
  password: string;
}

export interface AuthError {
  message: string;
  errors?: Record<string, string[]>;
} 
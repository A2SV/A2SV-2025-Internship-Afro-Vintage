import { BundleStatus } from '../config/status';
import { User } from './user';

export interface Bundle {
  id: string;
  supplierId: string;
  title: string;
  description: string;
  price: number;
  status: BundleStatus;
  images: string[];
  category: string;
  condition: string;
  weight: number;
  dimensions: {
    length: number;
    width: number;
    height: number;
  };
  createdAt: Date;
  updatedAt: Date;
  supplier?: User;
}

export interface BundleItem {
  id: string;
  bundleId: string;
  name: string;
  description: string;
  quantity: number;
  condition: string;
  estimatedValue: number;
  images: string[];
}

export interface CreateBundleInput {
  title: string;
  description: string;
  price: number;
  images: string[];
  category: string;
  condition: string;
  weight: number;
  dimensions: {
    length: number;
    width: number;
    height: number;
  };
  items: Omit<BundleItem, 'id' | 'bundleId'>[];
}

export interface UpdateBundleInput extends Partial<CreateBundleInput> {
  status?: BundleStatus;
} 
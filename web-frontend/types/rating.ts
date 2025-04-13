import { User } from './user';
import { Order } from './order';

export interface Rating {
  id: string;
  userId: string;
  orderId: string;
  rating: number;
  comment?: string;
  createdAt: Date;
  updatedAt: Date;
  user?: User;
  order?: Order;
}

export interface CreateRatingInput {
  orderId: string;
  rating: number;
  comment?: string;
}

export interface UpdateRatingInput {
  rating?: number;
  comment?: string;
}

export interface RatingSummary {
  averageRating: number;
  totalRatings: number;
  ratingDistribution: {
    [key: number]: number;
  };
}

export interface TrustScore {
  userId: string;
  score: number;
  factors: {
    ratingAverage: number;
    ratingCount: number;
    orderCompletionRate: number;
    responseTime: number;
    disputeRate: number;
  };
  updatedAt: Date;
} 
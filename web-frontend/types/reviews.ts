export interface Review {
  id: string;
  itemId: string;
  userId: string;
  userName: string;
  rating: number;
  comment: string;
  createdAt: string;
}

export interface ResellerRating {
  resellerId: string;
  averageRating: number;
  reviewCount: number;
  reviews: Review[];
} 
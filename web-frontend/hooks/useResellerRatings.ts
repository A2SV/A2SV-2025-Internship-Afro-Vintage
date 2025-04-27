import { useState, useEffect } from 'react';
import { ResellerRating } from '@/types/reviews';

export function useResellerRatings(resellerId: string) {
  const [ratings, setRatings] = useState<ResellerRating | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    const fetchRatings = async () => {
      try {
        const response = await fetch(`/api/resellers/${resellerId}/ratings`);
        if (!response.ok) {
          throw new Error('Failed to fetch reseller ratings');
        }
        const data = await response.json();
        setRatings(data);
      } catch (err) {
        setError(err instanceof Error ? err : new Error('Failed to fetch ratings'));
      } finally {
        setLoading(false);
      }
    };

    fetchRatings();
  }, [resellerId]);

  return { ratings, loading, error };
} 
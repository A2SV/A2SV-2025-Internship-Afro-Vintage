/**
 * Converts a rating from 100 scale to 5 scale
 * @param rating - Rating on a scale of 100
 * @returns Rating on a scale of 5, rounded to 1 decimal place
 */
export function convertRatingToFiveScale(rating: number): number {
  return Number(((rating / 100) * 5).toFixed(1));
}

/**
 * Converts a rating from 5 scale to 100 scale
 * @param rating - Rating on a scale of 5
 * @returns Rating on a scale of 100, rounded to nearest integer
 */
export function convertRatingToHundredScale(rating: number): number {
  return Math.round((rating / 5) * 100);
} 
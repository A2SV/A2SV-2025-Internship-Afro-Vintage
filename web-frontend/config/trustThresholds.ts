export const trustScoreThresholds = {
  FIVE_STARS: 90,
  FOUR_STARS: 75,
  THREE_STARS: 60,
  TWO_STARS: 40,
  ONE_STAR: 20,
};

export const calculateStarRating = (trustScore: number): number => {
  if (trustScore >= trustScoreThresholds.FIVE_STARS) return 5;
  if (trustScore >= trustScoreThresholds.FOUR_STARS) return 4;
  if (trustScore >= trustScoreThresholds.THREE_STARS) return 3;
  if (trustScore >= trustScoreThresholds.TWO_STARS) return 2;
  if (trustScore >= trustScoreThresholds.ONE_STAR) return 1;
  return 0;
}; 
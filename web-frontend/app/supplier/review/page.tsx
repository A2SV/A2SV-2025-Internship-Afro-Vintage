interface Review {
  author: string;
  text: string;
  profilePic: string;
  rating: number;
}

const ReviewsSection = () => {
  const reviews: Review[] = [
    // Add more reviews as needed...
    {
      author: "Liam Johnson",
      profilePic: "/liam-profile.jpg",
      rating: 4.5,
      text: "I was surprised by the variety available! Be many choices, and each one looked so appealing. I’ll definitely be back to try more products!",
    },
    {
      author: "Close Help",
      profilePic: "/close-help-profile.jpg",
      rating: 3.8,
      text: "The product quality is excellent but I felt it was a bit too expensive for what I received. If prices were more reasonable, I’d probably buy more.",
    },
    {
      author: "Liam Johnson",
      profilePic: "/liam-profile.jpg",
      rating: 4.5,
      text: "I was surprised by the variety available! Be many choices, and each one looked so appealing. I’ll definitely be back to try more products!",
    },
    {
      author: "Close Help",
      profilePic: "/close-help-profile.jpg",
      rating: 3.8,
      text: "The product quality is excellent but I felt it was a bit too expensive for what I received. If prices were more reasonable, I’d probably buy more.",
    },
    {
      author: "Liam Johnson",
      profilePic: "/liam-profile.jpg",
      rating: 4.5,
      text: "I was surprised by the variety available! Be many choices, and each one looked so appealing. I’ll definitely be back to try more products!",
    },
    {
      author: "Close Help",
      profilePic: "/close-help-profile.jpg",
      rating: 3.8,
      text: "The product quality is excellent but I felt it was a bit too expensive for what I received. If prices were more reasonable, I’d probably buy more.",
    },
    {
      author: "Liam Johnson",
      profilePic: "/liam-profile.jpg",
      rating: 4.5,
      text: "I was surprised by the variety available! Be many choices, and each one looked so appealing. I’ll definitely be back to try more products!",
    },
    {
      author: "Close Help",
      profilePic: "/close-help-profile.jpg",
      rating: 3.8,
      text: "The product quality is excellent but I felt it was a bit too expensive for what I received. If prices were more reasonable, I’d probably buy more.",
    },
  ];

  const renderStars = (rating: number) => {
    const fullStars = Math.floor(rating);
    const hasHalfStar = rating % 1 >= 0.5;

    return (
      <div className="flex items-center gap-1">
        {[...Array(5)].map((_, index) => {
          if (index < fullStars) {
            return (
              <svg
                key={index}
                className="w-5 h-5 text-yellow-400"
                fill="currentColor"
                viewBox="0 0 20 20"
              >
                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
              </svg>
            );
          }
          if (hasHalfStar && index === fullStars) {
            return (
              <div key={index} className="relative">
                <svg
                  className="w-5 h-5 text-gray-300"
                  fill="currentColor"
                  viewBox="0 0 20 20"
                >
                  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                </svg>
                <div className="absolute top-0 left-0 w-1/2 overflow-hidden">
                  <svg
                    className="w-5 h-5 text-yellow-400"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                  </svg>
                </div>
              </div>
            );
          }
          return (
            <svg
              key={index}
              className="w-5 h-5 text-gray-300"
              fill="currentColor"
              viewBox="0 0 20 20"
            >
              <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
            </svg>
          );
        })}
      </div>
    );
  };

  return (
    <div className="max-w-screen-xl mx-auto px-6 py-10">
      <h1 className="text-4xl font-bold text-gray-900 mb-10 text-center">
        Customer Reviews
      </h1>

      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
        {reviews.map((review, index) => (
          <div
            key={index}
            className="bg-white rounded-xl shadow-lg p-8 min-h-[210px] hover:shadow-2xl transition-shadow"
          >
            <div className="flex items-start gap-4 mb-4">
              <img
                src={review.profilePic}
                alt={review.author}
                className="w-14 h-14 rounded-full object-cover"
              />
              <div>
                <h3 className="text-xl font-semibold text-gray-900">
                  {review.author}
                </h3>
                <div className="flex items-center gap-2">
                  {renderStars(review.rating)}
                  <span className="text-sm text-gray-500">
                    ({review.rating.toFixed(1)})
                  </span>
                </div>
              </div>
            </div>
            <p className="text-gray-700 text-base leading-relaxed">
              {review.text}
            </p>
          </div>
        ))}
      </div>
    </div>
  );
};

export default ReviewsSection;

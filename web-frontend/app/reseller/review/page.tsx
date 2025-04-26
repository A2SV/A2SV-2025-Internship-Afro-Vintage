interface Review {
  author: string;
  text: string;
  profilePic: string;
  rating: number;
}

const ReviewsSection = () => {
  const reviews: Review[] = [
    {
      author: "Liam Johnson",
      profilePic: "/liam-profile.jpg",
      rating: 4.5,
      text: "Absolutely loved the service. Highly recommended!",
    },
    {
      author: "Sophie Brown",
      profilePic: "/sophie-profile.jpg",
      rating: 4.2,
      text: "Good experience overall, just some minor issues.",
    },
    {
      author: "Noah Smith",
      profilePic: "/noah-profile.jpg",
      rating: 5.0,
      text: "Fantastic quality and speedy delivery!",
    },
    {
      author: "Emma Wilson",
      profilePic: "/emma-profile.jpg",
      rating: 3.9,
      text: "Decent, but there’s definitely room for improvement.",
    },
    {
      author: "Oliver Davis",
      profilePic: "/oliver-profile.jpg",
      rating: 4.8,
      text: "Exceeded my expectations in every way!",
    },
    {
      author: "Ava Martinez",
      profilePic: "/ava-profile.jpg",
      rating: 4.0,
      text: "Nice packaging and good customer support.",
    },
    {
      author: "Elijah Garcia",
      profilePic: "/elijah-profile.jpg",
      rating: 3.7,
      text: "Product was okay but delivery took too long.",
    },
    {
      author: "Mia Anderson",
      profilePic: "/mia-profile.jpg",
      rating: 4.6,
      text: "Loved it! Will be purchasing again for sure.",
    },
    {
      author: "Lucas Thomas",
      profilePic: "/lucas-profile.jpg",
      rating: 4.3,
      text: "Solid experience, would recommend to friends.",
    },
  ];

  const renderStars = (rating: number) => {
    const fullStars = Math.floor(rating);
    const hasHalfStar = rating % 1 >= 0.5;

    return (
      <div className="flex items-center gap-[2px]">
        {[...Array(5)].map((_, index) => {
          if (index < fullStars) {
            return (
              <svg
                key={index}
                className="w-4 h-4 text-yellow-400"
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
                  className="w-4 h-4 text-gray-300"
                  fill="currentColor"
                  viewBox="0 0 20 20"
                >
                  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                </svg>
                <div className="absolute top-0 left-0 w-1/2 overflow-hidden">
                  <svg
                    className="w-4 h-4 text-yellow-400"
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
              className="w-4 h-4 text-gray-300"
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
    <div className="max-w-screen-xl mx-auto px-4 py-8 bg-white">
      <h1 className="text-3xl font-bold text-gray-900 mb-8 text-center">
        Customer Reviews
      </h1>

      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        {reviews.map((review, index) => (
          <div
            key={index}
            className="bg-white rounded-lg shadow-md p-6 min-h-[160px] hover:shadow-lg transition-shadow"
          >
            <div className="flex items-start gap-3 mb-3">
              <img
                src={review.profilePic}
                alt={review.author}
                className="w-10 h-10 rounded-full object-cover"
              />
              <div>
                <h3 className="text-lg font-semibold text-gray-900">
                  {review.author}
                </h3>
                <div className="flex items-center gap-1">
                  {renderStars(review.rating)}
                  <span className="text-xs text-gray-500">
                    ({review.rating.toFixed(1)})
                  </span>
                </div>
              </div>
            </div>
            <p className="text-gray-700 text-sm leading-relaxed">
              {review.text}
            </p>
          </div>
        ))}
      </div>
    </div>
  );
};

export default ReviewsSection;

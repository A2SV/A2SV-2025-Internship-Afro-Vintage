// Model for the create bundle API request
class BundleRequestModel {
  final String title;
  final String sampleImage;
  final int quantity;
  final String grade;
  final double price;
  final String description;
  final String type;
  final int declaredRating;
  final String sizeRange;
  final String sortingLevel;

  BundleRequestModel({
    required this.title,
    required this.sampleImage,
    required this.quantity,
    required this.grade,
    required this.price,
    required this.description,
    required this.type,
    required this.declaredRating,
    this.sizeRange = '',
    this.sortingLevel = 'sorted',
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'sample_image': sampleImage,
        'quantity': quantity,
        'grade': grade,
        'price': price,
        'description': description,
        'type': type,
        'declared_rating': declaredRating,
        'size_range': sizeRange,
        'sorting_level': sortingLevel,
      };
}

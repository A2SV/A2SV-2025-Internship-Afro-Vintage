import 'package:equatable/equatable.dart';

class BundleDetail extends Equatable {
  final String id;
  final String title;
  final String description;
  final String sampleImage;
  final int quantity;
  final String grade;
  final String sortingLevel;
  final String type;
  final double price;
  final String status;
  final int declaredRating;
  final String sizeRange;
  final DateTime? createdAt;

  const BundleDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.sampleImage,
    required this.quantity,
    required this.grade,
    required this.sortingLevel,
    required this.type,
    required this.price,
    required this.status,
    required this.declaredRating,
    required this.sizeRange,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        sampleImage,
        quantity,
        grade,
        sortingLevel,
        type,
        price,
        status,
        declaredRating,
        sizeRange,
        createdAt,
      ];
} 
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final double price;
  final String image_url;
  final String? grade;
  final String size;
  final String status;
  final String seller_id;
  final double rating;
  final String description;
  final String type;
  final String bundle_id;

  Product(this.grade,
      {required this.id,
      required this.title,
      required this.price,
      required this.image_url,
      required this.size,
      required this.status,
      required this.seller_id,
      required this.rating,
      required this.description,
      required this.type,
      required this.bundle_id});

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        image_url,
        grade,
        size,
        status,
        seller_id,
        rating,
        description,
        type,
        bundle_id
      ];
}

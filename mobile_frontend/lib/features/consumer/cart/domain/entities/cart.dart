import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final String? id;
  final String listing_id;
  final String? title;
  final double? price;
  final String? imageURL;
  final String? grade;
  final DateTime? createdAt;

  const Cart(this.id, this.title, this.price, this.imageURL, this.grade,
      this.createdAt,
      {required this.listing_id});

  @override
  List<Object?> get props =>
      [id, listing_id, title, price, imageURL, grade, createdAt];
}

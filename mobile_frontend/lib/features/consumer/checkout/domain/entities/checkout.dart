import 'package:equatable/equatable.dart';

class Checkout extends Equatable {
  final double totalAmount;
  final double platformFee;
  final double netPayable;
  final List<CheckoutItem> items;

  const Checkout({
    required this.totalAmount,
    required this.platformFee,
    required this.netPayable,
    required this.items,
  });

  @override
  List<Object?> get props => [totalAmount, platformFee, netPayable, items];
}

class CheckoutItem extends Equatable {
  final String listingID;
  final String? title;
  final double? price;
  final String? sellerID;
  final String? status;

  const CheckoutItem({
    required this.listingID,
    this.title,
    this.price,
    this.sellerID,
    this.status,
  });

  @override
  List<Object?> get props => [listingID, title, price, sellerID, status];
}

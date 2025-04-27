import 'package:mobile_frontend/features/consumer/checkout/domain/entities/checkout.dart';

class CheckoutModel extends Checkout {
  const CheckoutModel({
    required double totalAmount,
    required double platformFee,
    required double netPayable,
    required List<CheckoutItemModel> items,
  }) : super(
          totalAmount: totalAmount,
          platformFee: platformFee,
          netPayable: netPayable,
          items: items,
        );
  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    final data =
        json['data'] as Map<String, dynamic>?; // Extract the 'data' object
    return CheckoutModel(
      totalAmount:
          (data?['totalAmount'] as num?)?.toDouble() ?? 0.0, // Handle null
      platformFee:
          (data?['platformFee'] as num?)?.toDouble() ?? 0.0, // Handle null
      netPayable:
          (data?['netPayable'] as num?)?.toDouble() ?? 0.0, // Handle null
      items: (data?['items'] as List<dynamic>?)
              ?.map((item) =>
                  CheckoutItemModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [], // Provide a default empty list if 'items' is null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalAmount': totalAmount,
      'platformFee': platformFee,
      'netPayable': netPayable,
      'items':
          items.map((item) => (item as CheckoutItemModel).toJson()).toList(),
    };
  }

  Checkout toEntity() {
    return Checkout(
      totalAmount: totalAmount,
      platformFee: platformFee,
      netPayable: netPayable,
      items: items, // Ensure items are already of type List<CheckoutItem>
    );
  }
}

class CheckoutItemModel extends CheckoutItem {
  const CheckoutItemModel({
    required String listingID,
    String? title,
    double? price,
    String? sellerID,
    String? status,
  }) : super(
          listingID: listingID,
          title: title,
          price: price,
          sellerID: sellerID,
          status: status,
        );

  factory CheckoutItemModel.fromJson(Map<String, dynamic> json) {
    return CheckoutItemModel(
      listingID: json['listingId'] as String? ??
          '', // Handle null with a default empty string
      title: json['title'] as String? ??
          '', // Handle null with a default empty string
      price: (json['price'] as num?)?.toDouble() ??
          0.0, // Handle null with a default value of 0.0
      sellerID: json['sellerId'] as String? ??
          '', // Handle null with a default empty string
      status: json['status'] as String? ??
          '', // Handle null with a default empty string
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listingID': listingID,
      'title': title,
      'price': price,
      'sellerID': sellerID,
      'status': status,
    };
  }
}

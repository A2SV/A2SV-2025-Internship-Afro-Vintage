import 'package:flutter/material.dart';
import 'package:mobile_frontend/features/consumer/orders/domain/entities/order.dart';
import 'package:mobile_frontend/features/consumer/reviews/presentation/pages/add_review.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;
  final String label;
  final String colored;
  final String unColored;

  const OrderCard({
    super.key,
    required this.order,
    required this.label,
    required this.colored,
    required this.unColored,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Placeholder
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Image.asset(
                  "assets/images/cloth_3.png",
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(width: 16),
              // Order Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.products.isNotEmpty
                          ? order.products[0].title
                          : "Unknown Product",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "ID: ${order.id}",
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF5C5F6A)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "\$${order.totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Add Review Button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddReview(order: order),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
              ),
              icon: const Icon(
                Icons.rate_review,
                size: 18,
                color: Colors.white,
              ),
              label: const Text(
                'Add Review',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

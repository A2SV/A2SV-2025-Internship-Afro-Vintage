import 'package:flutter/material.dart';
import 'item_card.dart';

class GridItem extends StatelessWidget {
  final Function(String) onCartToggle;
  final List<Map<String, dynamic>> items;

  const GridItem({super.key, required this.onCartToggle, required this.items});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          mainAxisSpacing: 20,
          crossAxisSpacing: 15,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ItemCard(
            itemId: item['id'] ?? '',
            itemName: item['name'] ?? '',
            itemPrice: item['price'] != null ? item['price'].toString() : '',
            itemDescription: item['description'] ?? item['name'] ?? '', // fallback to name if description missing
            onCartToggle: (_) {}, // No cart icon, but required by ItemCard
            declaredRating: item['declared_rating'] ?? 0, // Set default to 89 if not provided
          );
        },
      ),
    );
  }
}

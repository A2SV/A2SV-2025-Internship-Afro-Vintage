import 'package:flutter/material.dart';
import 'item_card.dart';

class GridItem extends StatelessWidget {
  final Function(String) onCartToggle;

  const GridItem({super.key, required this.onCartToggle});

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
        itemCount: 6,
        itemBuilder: (context, index) {
          final itemName = "Casual women's tops collection $index";
          const itemPrice = '\$2400.99';
          return ItemCard(
            itemName: itemName,
            itemPrice: itemPrice,
            onCartToggle: onCartToggle,
          );
        },
      ),
    );
  }
}

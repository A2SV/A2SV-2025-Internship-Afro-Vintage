import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/features/consumer/marketplace/presentation/bloc/product_state.dart';
import '../bloc/product_bloc.dart';
import 'item_card.dart';

class GridItem extends StatelessWidget {
  final Function(String) onCartToggle;

  const GridItem({super.key, required this.onCartToggle});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 48) / 2;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Success) {
          final products = state.data;

          // Check if the products list is empty
          if (products.isEmpty) {
            return const Center(child: Text('No products available.'));
          }

          return Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: cardWidth / 290,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ItemCard(product: product, cardWidth: cardWidth);
              },
            ),
          );
        } else if (state is Error) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No products available.'));
        }
      },
    );
  }
}

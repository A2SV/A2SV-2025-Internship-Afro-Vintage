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
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Success) {
          final products = state.data;
          // print("Products $products");
          return Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                mainAxisSpacing: 20,
                crossAxisSpacing: 15,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ItemCard(
                  title: product.title,
                  itemPrice: '\$${product.price}',
                  rating: product.rating,
                  imageUrl: product.photo,
                  id: product.id,
                  // onCartToggle: onCartToggle,
                );
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

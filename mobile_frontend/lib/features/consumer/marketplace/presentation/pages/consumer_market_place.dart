import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';
import 'package:mobile_frontend/core/widgets/common_app_bar.dart';
import 'package:mobile_frontend/core/widgets/search_market.dart';
import 'package:mobile_frontend/core/widgets/side_menu.dart';
import 'package:mobile_frontend/features/consumer/marketplace/presentation/bloc/product_bloc.dart';
import 'package:mobile_frontend/features/consumer/marketplace/presentation/bloc/product_event.dart';
import 'package:mobile_frontend/features/consumer/marketplace/presentation/bloc/product_state.dart';
import 'package:mobile_frontend/features/consumer/marketplace/presentation/widgets/grid_item.dart';
import '../../../cart/presentation/pages/cart_page.dart';

class ConsumerMarketPlace extends StatefulWidget {
  const ConsumerMarketPlace({super.key});

  @override
  State<ConsumerMarketPlace> createState() => _ConsumerMarketPlaceState();
}

class _ConsumerMarketPlaceState extends State<ConsumerMarketPlace> {
  final List<String> _cartItems = [];
  List<dynamic> _products = []; // Store fetched products here

  @override
  void initState() {
    super.initState();
    // Dispatch the GetProductsEvent to fetch products
    context.read<ProductBloc>().add(GetProductsEvent());
  }

  void _toggleCart(String item) {
    setState(() {
      if (_cartItems.contains(item)) {
        _cartItems.remove(item);
      } else {
        _cartItems.add(item);
      }
    });
  }

  void _viewCart() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return CartBottomSheet(
          onCartToggle: _toggleCart,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: const CommonAppBar(title: 'Market Place'),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Success) {
            _products = state.data; // Store products in the state

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  SearchMarket(
                      products: _products), // Pass products to SearchMarket
                  const SizedBox(height: 25),
                  GridItem(onCartToggle: _toggleCart),
                ],
              ),
            );
          } else if (state is Error) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No products available.'));
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(onCartTap: _viewCart),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';
import 'package:mobile_frontend/core/widgets/common_app_bar.dart';
import 'package:mobile_frontend/core/widgets/search_market.dart';
import 'package:mobile_frontend/core/widgets/side_menu.dart';
import 'package:mobile_frontend/features/consumer/marketplace/presentation/bloc/product_bloc.dart';
import 'package:mobile_frontend/features/consumer/marketplace/presentation/bloc/product_event.dart';
import 'package:mobile_frontend/features/consumer/marketplace/presentation/widgets/grid_item.dart';
import '../../../cart/presentation/pages/cart_page.dart';

class ConsumerMarketPlace extends StatefulWidget {
  const ConsumerMarketPlace({super.key});

  @override
  State<ConsumerMarketPlace> createState() => _ConsumerMarketPlaceState();
}

class _ConsumerMarketPlaceState extends State<ConsumerMarketPlace> {
  final List<String> _cartItems = [];

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 25),
            const SearchMarket(),
            const SizedBox(height: 25),
            GridItem(onCartToggle: _toggleCart),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(onCartTap: _viewCart),
    );
  }
}

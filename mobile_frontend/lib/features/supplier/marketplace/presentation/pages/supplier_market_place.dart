import 'package:flutter/material.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';
import 'package:mobile_frontend/core/widgets/common_app_bar.dart';
import 'package:mobile_frontend/core/widgets/search_market.dart';
import 'package:mobile_frontend/core/widgets/side_menu.dart';
import '../../data/datasources/bundle_remote_data_source.dart';
import '../../data/models/bundle_model.dart';
import '../../../../consumer/cart/presentation/pages/cart_page.dart';
import '../widgets/grid_item.dart';
import 'dart:async';

class SupplierMarketPlace extends StatefulWidget {
  const SupplierMarketPlace({super.key});

  @override
  State<SupplierMarketPlace> createState() => _SupplierMarketPlaceState();
}

class _SupplierMarketPlaceState extends State<SupplierMarketPlace> {
  final List<String> _cartItems = [];
  final BundleRemoteDataSource _bundleRemoteDataSource = BundleRemoteDataSource();
  List<BundleModel> _bundles = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchAndSetItems();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchAndSetItems();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchAndSetItems() async {
    setState(() { _loading = true; _error = null; });
    try {
      final bundles = await _bundleRemoteDataSource.fetchBundles();
      setState(() {
        _bundles = bundles;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
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

  void _goToCreateBundle() async {
    final result = await Navigator.pushNamed(context, '/createbundle');
    if (result == true) {
      setState(() {}); // Refresh the marketplace
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: const CommonAppBar(title: 'Warehouse'),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: \\$_error'))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      SearchMarket(products: _bundles),
                      const SizedBox(height: 25),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: _goToCreateBundle,
                          child: const Text('Create Bundle'),
                        ),
                      ),
                      Expanded(
                        child: GridItem(
                          items: _bundles
                              .where((bundle) => bundle.status == 'available')
                              .map((bundle) => {
                                    'id': bundle.id,
                                    'name': bundle.title,
                                    'price': bundle.price,
                                    'description': bundle.description ?? bundle.title,
                                    'image': 'assets/images/cloth_2.png',
                                    'declared_rating': bundle.declaredRating,
                                  })
                              .toList(),
                          onCartToggle: _toggleCart,
                        ),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: BottomNavBar(onCartTap: _viewCart),
    );
  }
}

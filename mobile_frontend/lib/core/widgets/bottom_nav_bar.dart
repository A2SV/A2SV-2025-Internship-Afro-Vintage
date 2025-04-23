import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final VoidCallback onCartTap;

  const BottomNavBar({super.key, required this.onCartTap});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final List<String> _routes = [
    '/consumermarketplace',
    '/consumermarketplace',
    '/allorder',
    '/reviews',
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _currentIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _currentIndex = index;
        });
        if (index == 2) {
          widget.onCartTap();
        } else {
          Navigator.pushNamed(context, _routes[index]);
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.storefront_rounded),
          label: 'Market',
        ),
        NavigationDestination(
          icon: Icon(Icons.message),
          label: 'Message',
        ),
        NavigationDestination(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: 'Me',
        ),
      ],
    );
  }
}

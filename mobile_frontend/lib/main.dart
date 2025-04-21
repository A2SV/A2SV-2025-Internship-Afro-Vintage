import 'package:flutter/material.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/pages/order_detail.dart';
import 'package:mobile_frontend/features/consumer/reviews/presentation/pages/reviews.dart';
import 'package:mobile_frontend/features/consumer/checkout/presentation/pages/add_address.dart';
import 'package:mobile_frontend/features/consumer/reviews/presentation/pages/add_review.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/pages/all_orders.dart';
import 'package:mobile_frontend/features/consumer/checkout/presentation/pages/checkout.dart';
import 'package:mobile_frontend/features/consumer/marketplace/presentation/pages/consumer_market_place.dart';
import 'package:mobile_frontend/features/consumer/product_detail/presentation/pages/product_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF008080),
          brightness: Brightness.light,
        ).copyWith(
          secondary: const Color(0xFF006666),
          tertiary: const Color(0xFF00A3A3),
        ),
        fontFamily: 'Poppins',
        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                color: Color(0xFF008080),
              );
            }
            return const TextStyle(color: Colors.grey);
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(
                color: Color(0xFF008080),
              ); // selected icon
            }
            return const IconThemeData(color: Colors.grey);
          }),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ConsumerMarketPlace(),
        '/allorder': (context) => const AllOrders(),
        '/addreview': (context) => const AddReview(),
        '/reviews': (context) => const Reviews(),
        '/productdetail': (context) => const ProductDetailPage(),
        '/addaddress': (context) => const AddAddress(),
        '/checkout': (context) => const Checkout(),
        '/orderdetail': (context) => const OrderDetail(),
      },
    );
  }
}

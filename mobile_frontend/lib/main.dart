import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_frontend/features/auth/presentation/pages/signin.dart';
import 'package:mobile_frontend/features/auth/presentation/pages/landing_page.dart';
import 'package:mobile_frontend/features/auth/presentation/pages/role.dart';
import 'package:mobile_frontend/features/auth/presentation/pages/signup.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_bloc.dart';
import 'package:mobile_frontend/features/consumer/marketplace/presentation/bloc/product_bloc.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/pages/order_detail.dart';
import 'package:mobile_frontend/features/consumer/reviews/presentation/pages/reviews.dart';
import 'package:mobile_frontend/features/consumer/checkout/presentation/pages/add_address.dart';
import 'package:mobile_frontend/features/consumer/reviews/presentation/pages/add_review.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/pages/all_orders.dart';
import 'package:mobile_frontend/features/consumer/checkout/presentation/pages/checkout.dart';
import 'package:mobile_frontend/features/consumer/marketplace/presentation/pages/consumer_market_place.dart';
import 'package:mobile_frontend/features/consumer/product_detail/presentation/pages/product_detail.dart';
import 'package:mobile_frontend/injection_container.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>()),
        BlocProvider<ProductBloc>(create: (context) => sl<ProductBloc>()),
        BlocProvider<CartBloc>(create: (context) => sl<CartBloc>()),
      ],
      child: const MyApp(),
    ),
  );
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
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/role') {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (context) => RoleSelectionPage(
              username: args['username']!,
              email: args['email']!,
              password: args['password']!,
            ),
          );
        }
        return null;
      },
      routes: {
        '/': (context) => const LandingPage(),
        '/signup': (context) => const SignupPage(),
        '/signin': (context) => const SigninPage(),
        '/consumermarketplace': (context) => const ConsumerMarketPlace(),
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

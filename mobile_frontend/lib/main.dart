import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_frontend/features/auth/presentation/pages/signin.dart';
import 'package:mobile_frontend/features/auth/presentation/pages/landing_page.dart';
import 'package:mobile_frontend/features/auth/presentation/pages/role.dart';
import 'package:mobile_frontend/features/auth/presentation/pages/signup.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_bloc.dart';
import 'package:mobile_frontend/features/consumer/checkout/domain/entities/checkout.dart';
import 'package:mobile_frontend/features/consumer/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:mobile_frontend/features/consumer/marketplace/domain/entities/product.dart';
import 'package:mobile_frontend/features/consumer/marketplace/presentation/bloc/product_bloc.dart';
import 'package:mobile_frontend/features/consumer/orders/domain/entities/order.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/bloc/order_bloc.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/pages/order_detail.dart';
import 'package:mobile_frontend/features/consumer/reviews/presentation/bloc/review_bloc.dart';
import 'package:mobile_frontend/features/consumer/reviews/presentation/pages/reviews.dart';
import 'package:mobile_frontend/features/consumer/checkout/presentation/pages/add_address.dart';
import 'package:mobile_frontend/features/consumer/reviews/presentation/pages/add_review.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/pages/all_orders.dart';
import 'package:mobile_frontend/features/consumer/checkout/presentation/pages/checkout_page.dart';
import 'package:mobile_frontend/features/consumer/marketplace/presentation/pages/consumer_market_place.dart'
    as consumer;
import 'package:mobile_frontend/features/consumer/product_detail/presentation/pages/product_detail.dart';
import 'package:mobile_frontend/features/reseller/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:mobile_frontend/features/reseller/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:mobile_frontend/features/reseller/dashboard/presentation/pages/reseller_warehouse_page.dart';
import 'package:mobile_frontend/features/reseller/marketplace/presentation/blocs/marketplace_bloc.dart';
import 'package:mobile_frontend/features/reseller/marketplace/presentation/blocs/payment/payment_bloc.dart';
import 'package:mobile_frontend/features/reseller/marketplace/presentation/pages/supplier_reseller_marketplace.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/presentation/bloc/reseller_order_bloc.dart';
import 'package:mobile_frontend/features/reseller/unpack/presentation/bloc/unpack_bloc.dart';
import 'package:mobile_frontend/features/supplier/dashboard/presentation/pages/dashboard_page.dart';
import 'package:mobile_frontend/features/supplier/history/presentation/pages/history_page.dart';
import 'package:mobile_frontend/features/supplier/marketplace/presentation/pages/supplier_market_place.dart';
import 'package:mobile_frontend/features/supplier/bundle/create_bundle/presentation/pages/create_bundle.dart';
import 'package:mobile_frontend/features/supplier/bundle/edit_bundle/presentation/pages/edit_bundle.dart';
import 'package:mobile_frontend/features/supplier/bundle/remove_bundle/presentation/pages/remove_bundle.dart';
import 'package:mobile_frontend/features/supplier/product_detail/presentation/pages/product_detail.dart'
    as supplier;
import 'package:mobile_frontend/injection_container.dart';
import 'injection_container.dart' as di;
import 'package:mobile_frontend/features/reseller/reseller_order/presentation/pages/reseller_all_orders.dart';
import 'package:mobile_frontend/features/profile/presentation/bloc/profile_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>()),
        BlocProvider<ProductBloc>(create: (context) => sl<ProductBloc>()),
        BlocProvider<CartBloc>(create: (context) => sl<CartBloc>()),
        BlocProvider<CheckoutBloc>(create: (context) => sl<CheckoutBloc>()),
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<MarketplaceBloc>(),
        ),
        BlocProvider<DashboardBloc>(
          create: (context) =>
              di.sl<DashboardBloc>()..add(LoadDashboardMetrics()),
        ),
        BlocProvider<UnpackBloc>(
          create: (context) => di.sl<UnpackBloc>(),
        ),
        BlocProvider<PaymentBloc>(
          create: (context) => di.sl<PaymentBloc>(),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => sl<OrderBloc>(),
        ),
        BlocProvider<ResellerOrderBloc>(
          create: (context) => sl<ResellerOrderBloc>(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => sl<ProfileBloc>(),
        ),
        BlocProvider<ReviewBloc>(
          create: (context) => sl<ReviewBloc>(),
        ),
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
      title: 'Afro Vintage',
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
        '/consumermarketplace': (context) =>
            const consumer.ConsumerMarketPlace(),
        '/allorder': (context) => const AllOrders(),
        '/addreview': (context) => AddReview(
            order: ModalRoute.of(context)!.settings.arguments as OrderEntity),
        '/reviews': (context) => const Reviews(),
        '/productdetail': (context) => ProductDetailPage(
            product: ModalRoute.of(context)!.settings.arguments as Product),
        '/addaddress': (context) => const AddAddress(),
        '/checkout': (context) => CheckoutPage(
            checkoutData:
                ModalRoute.of(context)!.settings.arguments as Checkout),
        '/orderdetail': (context) => const OrderDetail(),
        '/supplier-reseller-marketplace': (context) =>
            const SupplierResellerMarketPlacePage(),
        '/reseller-warehouse': (context) => const ResellerWarehousePage(),
        '/dashboard': (context) => const SupplierDashboardPage(),
        '/History': (context) => const HistoryPage(),
        '/mywarehouse': (context) => const SupplierMarketPlace(),
        '/createbundle': (context) => const CreateBundleScreen(),
        '/editbundle': (context) => EditBundleScreen(
            bundleId: (ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>)['bundleId']),
        '/removebundle': (context) => const RemoveBundleScreen(),
        '/supplierproductdetail': (context) => supplier.ProductDetailPage(
            bundleId: (ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>)['bundleId']),
        '/reseller-all-orders': (context) => const ResellerAllOrders(),
      },
    );
  }
}

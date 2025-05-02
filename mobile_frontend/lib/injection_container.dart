import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_frontend/core/network/network_info.dart';
import 'package:mobile_frontend/features/auth/data/datasources/auth_data_source.dart';
import 'package:mobile_frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile_frontend/features/auth/domain/usecases/signin.dart';
import 'package:mobile_frontend/features/auth/domain/usecases/signup.dart';
import 'package:mobile_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_frontend/features/consumer/orders/data/datasources/order_data_source.dart';
import 'package:mobile_frontend/features/consumer/orders/data/repositories/order_repository_impl.dart';
import 'package:mobile_frontend/features/consumer/orders/domain/repositories/order_repository.dart';
import 'package:mobile_frontend/features/consumer/orders/domain/usecases/get_orders.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/bloc/order_bloc.dart';
import 'package:mobile_frontend/features/consumer/reviews/data/datasources/review_data_source.dart';
import 'package:mobile_frontend/features/consumer/reviews/data/repositories/review_repository_impl.dart';
import 'package:mobile_frontend/features/consumer/reviews/domain/repositories/review_repository.dart';
import 'package:mobile_frontend/features/consumer/reviews/domain/usecases/add_review.dart';
import 'package:mobile_frontend/features/consumer/reviews/presentation/bloc/review_bloc.dart';
import 'package:mobile_frontend/features/reseller/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:mobile_frontend/features/reseller/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:mobile_frontend/features/reseller/dashboard/domain/repository/dashboard_repository.dart';
import 'package:mobile_frontend/features/reseller/dashboard/domain/usecases/get_reseller_metrics.dart';
import 'package:mobile_frontend/features/reseller/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:mobile_frontend/features/reseller/marketplace/data/datasources/bundle_remote_data_source.dart';
import 'package:mobile_frontend/features/reseller/marketplace/data/repositories/bundle_repository_impl.dart';
import 'package:mobile_frontend/features/reseller/marketplace/domain/repositories/bundle_repository.dart';
import 'package:mobile_frontend/features/reseller/marketplace/domain/usecases/get_available_bundles.dart';
import 'package:mobile_frontend/features/reseller/marketplace/domain/usecases/get_bundle_details.dart';
import 'package:mobile_frontend/features/reseller/marketplace/domain/usecases/purchase_bundle.dart';
import 'package:mobile_frontend/features/reseller/marketplace/domain/usecases/search_bundles_by_title.dart';
import 'package:mobile_frontend/features/reseller/marketplace/presentation/blocs/marketplace_bloc.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/data/datasources/order_remote_data_source.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/data/repositories/order_repository_impl.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/domain/repository/reseller_order_repository.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/domain/usecases/get_order_history.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/presentation/bloc/reseller_order_bloc.dart';
import 'package:mobile_frontend/features/reseller/unpack/data/datasources/unpack_remote_data_source.dart';
import 'package:mobile_frontend/features/reseller/unpack/data/repositories/unpack_repository_impl.dart';
import 'package:mobile_frontend/features/reseller/unpack/domain/repository/unpack_repository.dart';
import 'package:mobile_frontend/features/reseller/unpack/domain/usecases/unpack_bundle_item.dart';
import 'package:mobile_frontend/features/reseller/unpack/presentation/bloc/unpack_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_frontend/features/consumer/cart/data/datasources/cart_data_source.dart';
import 'package:mobile_frontend/features/consumer/cart/data/repositories/cart_repository_impl.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/repositories/cart_repository.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/usecases/add_to_cart.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/usecases/fetch_cart.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/usecases/remove_from_cart.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_bloc.dart';
import 'package:mobile_frontend/features/consumer/checkout/data/datasources/checkout_data_source.dart';
import 'package:mobile_frontend/features/consumer/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:mobile_frontend/features/consumer/checkout/domain/repositories/checkout_repository.dart';
import 'package:mobile_frontend/features/consumer/checkout/domain/usecases/checkout.dart';
import 'package:mobile_frontend/features/consumer/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:mobile_frontend/features/consumer/marketplace/data/datasources/product_data_source.dart';
import 'package:mobile_frontend/features/consumer/marketplace/data/repositories/product_repository_impl.dart';
import 'package:mobile_frontend/features/consumer/marketplace/domain/repositories/product_repository.dart';
import 'package:mobile_frontend/features/consumer/marketplace/domain/usecases/get_products.dart';
import 'package:mobile_frontend/features/consumer/marketplace/presentation/bloc/product_bloc.dart';
import 'package:mobile_frontend/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:mobile_frontend/features/profile/data/datasources/profile_remote_data_source_impl.dart';
import 'package:mobile_frontend/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:mobile_frontend/features/profile/domain/repositories/profile_repository.dart';
import 'package:mobile_frontend/features/profile/domain/usecases/get_profile.dart';
import 'package:mobile_frontend/features/profile/presentation/bloc/profile_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory(
    () => AuthBloc(signup: sl(), signin: sl()),
  );

  sl.registerFactory(
    () => ProductBloc(getProducts: sl()),
  );

  sl.registerFactory(
    () => CartBloc(
        addToCartUseCase: sl(),
        fetchCartUseCase: sl(),
        removeFromCartUseCase: sl()),
  );

  sl.registerFactory(() => CheckoutBloc(performCheckoutUseCase: sl()));

  sl.registerFactory(() => OrderBloc(getOrders: sl()));

  sl.registerFactory(() => ReviewBloc(addReviewUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => SignupUseCase(repository: sl()));
  sl.registerLazySingleton(() => SigninUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProductsUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchCartUseCase(repository: sl()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(repository: sl()));
  sl.registerLazySingleton(() => CheckoutUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetOrdersUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddReviewUseCase(repository: sl()));

  // repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDataSource: sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(productDataSource: sl()),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(cartDataSource: sl()),
  );

  sl.registerLazySingleton<CheckoutRepository>(
    () => CheckoutRepositoryImpl(checkoutDataSource: sl()),
  );

  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(orderDataSource: sl()),
  );

  sl.registerLazySingleton<ReviewRepository>(
    () => ReviewRepositoryImpl(reviewDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ProductDataSource>(
    () => ProductDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<CartDataSource>(
    () => CartDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<CheckoutDataSource>(
    () => CheckoutDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<OrderDataSource>(
    () => OrderDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<ReviewDataSource>(
    () => ReviewDataSourceImpl(client: sl()),
  );

  // Marketplace
  // Bloc
  sl.registerFactory(
    () => MarketplaceBloc(
      getAvailableBundles: sl(),
      getBundleDetails: sl(),
      searchBundles: sl(),
      purchaseBundle: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAvailableBundles(sl()));
  sl.registerLazySingleton(() => GetBundleDetails(sl()));
  sl.registerLazySingleton(() => SearchBundlesByTitle(sl()));
  sl.registerLazySingleton(() => PurchaseBundle(sl()));

  // Repository
  sl.registerLazySingleton<BundleRepository>(
    () => BundleRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Dashboard Feature
  // Bloc
  sl.registerFactory(
    () => DashboardBloc(
      getResellerMetrics: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetResellerMetrics(sl()));

  // Repository
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(
      client: sl(),
      sharedPreferences: sl(),
    ),
  );

  // Unpack Feature
  // Bloc
  sl.registerFactory(
    () => UnpackBloc(unpackBundleItem: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => UnpackBundleItem(sl()));

  // Repository
  sl.registerLazySingleton<UnpackRepository>(
    () => UnpackRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<UnpackRemoteDataSource>(
    () => UnpackRemoteDataSourceImpl(
      client: sl(),
      sharedPreferences: sl(),
    ),
  );

  // Bloc
  sl.registerFactory(
    () => ResellerOrderBloc(getOrderHistory: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetOrderHistory(sl()));

  // Repository
  sl.registerLazySingleton<ResellerOrderRepository>(
    () => ResellerOrderRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(
      client: sl(),
      sharedPreferences: sl(),
    ),
  );

  // Get SharedPreferences instance
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Data sources
  sl.registerLazySingleton<BundleRemoteDataSource>(
    () => BundleRemoteDataSourceImpl(
      client: sl(),
      sharedPreferences: sl<SharedPreferences>(),
    ),
  );

  // Profile Feature
  // Bloc
  sl.registerFactory(
    () => ProfileBloc(getProfile: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetProfile(sl()));

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      client: sl(),
      sharedPreferences: sl(),
    ),
  );

  //! Core
  //! Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );
  // Add any core dependencies here

  //! Core

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}

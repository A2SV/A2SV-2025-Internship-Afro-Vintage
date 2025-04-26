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

  // Use cases
  sl.registerLazySingleton(() => SignupUseCase(repository: sl()));
  sl.registerLazySingleton(() => SigninUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProductsUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchCartUseCase(repository: sl()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(repository: sl()));
  sl.registerLazySingleton(() => CheckoutUseCase(repository: sl()));
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
      remoteDataSource: sl(),  networkInfo: sl() ,
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

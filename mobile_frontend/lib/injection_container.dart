import 'package:get_it/get_it.dart';
import 'package:mobile_frontend/features/auth/data/datasources/auth_data_source.dart';
import 'package:mobile_frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile_frontend/features/auth/domain/usecases/signin.dart';
import 'package:mobile_frontend/features/auth/domain/usecases/signup.dart';
import 'package:mobile_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:http/http.dart' as http;
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
  //! Core

  //! External
  sl.registerLazySingleton(() => http.Client());
}

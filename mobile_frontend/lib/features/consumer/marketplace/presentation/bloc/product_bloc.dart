import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/consumer/marketplace/domain/usecases/get_products.dart';
import 'package:mobile_frontend/features/consumer/marketplace/presentation/bloc/product_event.dart';
import 'package:mobile_frontend/features/consumer/marketplace/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProducts;

  ProductBloc({required this.getProducts}) : super(Empty()) {
    on<GetProductsEvent>(_getProducts);
  }

  Future<void> _getProducts(
      GetProductsEvent event, Emitter<ProductState> emit) async {
    emit(Loading());
    print("Loading state emitted");

    final result = await getProducts.call(NoParams());
    // print("Result from use case: $result");

    result.fold(
      (failure) {
        print("Error state emitted");
        emit(Error(message: 'Error in signup'));
      },
      (productResponse) {
        // print("Success state emitted with data: $productResponse");
        emit(Success(message: 'Get Product successful', data: productResponse));
      },
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_state.dart';
import 'package:mobile_frontend/features/consumer/orders/domain/usecases/get_orders.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/bloc/order_event.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrdersUseCase getOrders;

  OrderBloc({required this.getOrders}) : super(OrderEmpty()) {
    on<GetOrdersEvent>(_getOrders);
  }

  Future<void> _getOrders(
      GetOrdersEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    print("Loading state emitted");

    final result = await getOrders.call(NoParams());
    print("Result from use case: $result");

    result.fold(
      (failure) {
        print("Error state emitted");
        emit(OrderError(message: 'Error in signup'));
      },
      (orderResponse) {
        // print("Success state emitted with data: $OrderResponse");
        emit(
            OrderSuccess(message: 'Get Order successful', data: orderResponse));
      },
    );
  }
}

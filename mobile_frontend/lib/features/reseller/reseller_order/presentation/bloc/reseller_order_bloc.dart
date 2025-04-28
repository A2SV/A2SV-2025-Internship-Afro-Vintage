// lib/features/reseller/orders/presentation/bloc/order_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/domain/usecases/get_order_history.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/presentation/bloc/order_event.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/presentation/bloc/order_state.dart';

class ResellerOrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrderHistory getOrderHistory;

  ResellerOrderBloc({required this.getOrderHistory}) : super(OrderInitial()) {
    on<LoadOrderHistory>(_onLoadOrderHistory);
  }

  Future<void> _onLoadOrderHistory(
    LoadOrderHistory event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    final result = await getOrderHistory(NoParams());
    result.fold(
      (failure) => emit(OrderError(failure.toString())),
      (orderHistory) => emit(OrderLoaded(orderHistory)),
    );
  }
}
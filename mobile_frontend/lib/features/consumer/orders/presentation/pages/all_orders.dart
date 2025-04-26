import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';
import 'package:mobile_frontend/core/widgets/common_app_bar.dart';
import 'package:mobile_frontend/core/widgets/side_menu.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/bloc/order_bloc.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/bloc/order_event.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/bloc/order_state.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/widgets/order_card.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  @override
  void initState() {
    super.initState();
    // Trigger the GetOrdersEvent when the page is initialized
    context.read<OrderBloc>().add(const GetOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      drawer: SideMenu(),
      appBar: CommonAppBar(title: 'My Orders'),
      body: Column(
        children: [
          const SizedBox(height: 25),
          Expanded(
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                print("Current state: $state");
                if (state is OrderLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OrderSuccess) {
                  return ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      print("I'm here ${state.data[index]}");
                      final order = state.data[index];
                      return OrderCard(
                        order: order,
                        label: "Shipped",
                        colored: "Confirm",
                        unColored: "Refund",
                      );
                    },
                  );
                } else if (state is OrderError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text("No orders available."));
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(onCartTap: () {}),
    );
  }
}

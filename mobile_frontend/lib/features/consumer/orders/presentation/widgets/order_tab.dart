import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/bloc/order_bloc.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/bloc/order_event.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/pages/all_orders.dart';

class OrderTabs extends StatefulWidget {
  const OrderTabs({super.key});

  @override
  State<OrderTabs> createState() => _OrderTabsState();
}

class _OrderTabsState extends State<OrderTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _unselectedColor = const Color(0xff5f6368);

  final List<String> _tabLabels = const [
    'Shipped',
  ];

  @override
  void initState() {
    _tabController = TabController(length: _tabLabels.length, vsync: this);
    super.initState();
    // Trigger the GetOrdersEvent when the tabs are initialized
    context.read<OrderBloc>().add(const GetOrdersEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return Column(
      children: [
        const SizedBox(height: 25),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: _tabLabels.map((label) => Tab(text: label)).toList(),
            unselectedLabelColor: _unselectedColor,
            labelColor: Colors.white,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: secondaryColor,
            ),
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              AllOrders(), // Displays all shipped orders
            ],
          ),
        ),
      ],
    );
  }
}

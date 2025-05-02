import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';
import 'package:mobile_frontend/core/widgets/common_app_bar.dart';
import 'package:mobile_frontend/core/widgets/side_menu.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/domain/entities/order.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/presentation/bloc/reseller_order_bloc.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/presentation/bloc/order_event.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/presentation/bloc/order_state.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/presentation/pages/order_detail_page.dart';

class ResellerAllOrders extends StatefulWidget {
  const ResellerAllOrders({super.key});

  @override
  State<ResellerAllOrders> createState() => _ResellerAllOrdersState();
}

class _ResellerAllOrdersState extends State<ResellerAllOrders>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<ResellerOrderBloc>().add(LoadOrderHistory());
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      drawer: SideMenu(),
      appBar: CommonAppBar(title: 'Order History'),
      body: BlocBuilder<ResellerOrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderLoaded) {
            return Column(
              children: [
                Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.black,
                    indicatorWeight: 2.5,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                    unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 16),
                    tabs: const [
                      Tab(text: 'Bought Bundles'),
                      Tab(text: 'Sold Items'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Bought Bundles Tab
                      state.orderHistory.bought.isEmpty
                          ? const Center(child: Text('No bought bundles yet.'))
                          : ListView.builder(
                              itemCount: state.orderHistory.bought.length,
                              itemBuilder: (context, index) {
                                final order = state.orderHistory.bought[index];
                                return OrderCard(
                                  order: order.order,
                                  label: order.order.status,
                                  colored: "View Details",
                                  unColored: "Contact Supplier",
                                  subtitle:
                                      'Order from ${order.supplierName}',
                                );
                              },
                            ),
                      // Sold Items Tab
                      state.orderHistory.sold.isEmpty
                          ? const Center(child: Text('No sold items yet.'))
                          : ListView.builder(
                              itemCount: state.orderHistory.sold.length,
                              itemBuilder: (context, index) {
                                final order = state.orderHistory.sold[index];
                                return OrderCard(
                                  order: order.order,
                                  label: order.order.status,
                                  colored: "View Details",
                                  unColored: "Contact Consumer",
                                  subtitle: 'Order to ${order.consumerName}',
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is OrderError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ResellerOrderBloc>().add(LoadOrderHistory());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: BottomNavBar(onCartTap: () {}),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;
  final String label;
  final String colored;
  final String unColored;
  final String? subtitle;

  const OrderCard({
    super.key,
    required this.order,
    required this.label,
    required this.colored,
    required this.unColored,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final String orderId = 'Order #${order.id}';
    final String status = order.status;
    final String price = '\$${order.totalPrice.toStringAsFixed(2)}';
    final String date = order.createdAt.toLocal().toString().split(' ')[0];
    final bool isBoughtOrder = unColored == "Contact Supplier";

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and status row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    orderId,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: status.toLowerCase() == 'completed'
                        ? Colors.green[100]
                        : Colors.orange[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: status.toLowerCase() == 'completed'
                          ? Colors.green
                          : Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
            const SizedBox(height: 8),
            // Price and date row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _showContactDialog(context, isBoughtOrder);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Color(0xFF008080)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(unColored),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailPage(
                            order: order,
                            contactName: subtitle?.split(' ').last ?? 'Unknown',
                            isBoughtOrder: isBoughtOrder,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF008080),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      colored,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showContactDialog(BuildContext context, bool isBoughtOrder) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Contact ${isBoughtOrder ? 'Supplier' : 'Consumer'}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Send Email'),
                onTap: () {
                  // Implement email functionality
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email feature coming soon'),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Send Message'),
                onTap: () {
                  // Implement messaging functionality
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Messaging feature coming soon'),
                    ),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
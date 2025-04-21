import 'package:flutter/material.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';
import 'package:mobile_frontend/core/widgets/common_app_bar.dart';
import 'package:mobile_frontend/core/widgets/side_menu.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/widgets/order_card.dart';
import 'package:mobile_frontend/features/consumer/core/widgets/button.dart';
import 'package:mobile_frontend/features/consumer/orders/presentation/widgets/order_tab.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      drawer: const SideMenu(),
      appBar: const CommonAppBar(title: "My Orders"),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: OrderTabs(),
      ),
      bottomNavigationBar: BottomNavBar(
        onCartTap: () {},
      ),
    );
  }
}

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ToReceive(label: "Shipped", colored: "Confirm", unColored: "Refund"),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          ToShip(
            label: "Buyer has paid",
            colored: "Address",
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class ToReceive extends StatefulWidget {
  final String label;
  final String colored;
  final String unColored;
  const ToReceive(
      {super.key,
      required this.label,
      required this.colored,
      required this.unColored});

  @override
  State<ToReceive> createState() => _ToReceiveState();
}

class _ToReceiveState extends State<ToReceive> {
  @override
  Widget build(BuildContext context) {
    final Color accent = Theme.of(context).colorScheme.tertiary;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/orderdetail');
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dauphin Pastoureau',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                Column(
                  children: List.generate(
                    2,
                    (index) => const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: OrderCard(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Total',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 80),
                    Text(
                      '\$ 41.82',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: accent),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    UnColoredButton(
                      label: widget.colored,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 10),
                    ColoredButton(label: widget.unColored, onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ToShip extends StatefulWidget {
  final String label;
  final String colored;
  const ToShip({super.key, required this.label, required this.colored});

  @override
  State<ToShip> createState() => _ToShipState();
}

class _ToShipState extends State<ToShip> {
  @override
  Widget build(BuildContext context) {
    final Color accent = Theme.of(context).colorScheme.tertiary;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/orderdetail');
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dauphin Pastoureau',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                    Text(
                      widget.label,
                      style: const TextStyle(
                        color: Color(0xFFFF8039),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                Column(
                  children: List.generate(
                    2,
                    (index) => const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: OrderCard(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Total',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 80),
                    Text(
                      '\$ 41.82',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: accent),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 10),
                    ColoredButton(label: widget.colored, onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

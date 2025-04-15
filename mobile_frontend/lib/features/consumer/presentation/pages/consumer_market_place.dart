import 'package:flutter/material.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';
import 'package:mobile_frontend/core/widgets/side_menu.dart';
import 'package:mobile_frontend/features/consumer/presentation/widgets/common_app_bar.dart';
import 'package:mobile_frontend/core/widgets/search_market.dart';

class ConsumerMarketPlace extends StatefulWidget {
  const ConsumerMarketPlace({super.key});

  @override
  State<ConsumerMarketPlace> createState() => _ConsumerMarketPlaceState();
}

class _ConsumerMarketPlaceState extends State<ConsumerMarketPlace> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: SideMenu(),
      appBar: CommonAppBar(
        title: "Market Place",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [SearchMarket()],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

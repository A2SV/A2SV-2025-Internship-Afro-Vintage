import 'package:flutter/material.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';
import 'package:mobile_frontend/core/widgets/common_app_bar.dart';
import 'package:mobile_frontend/core/widgets/side_menu.dart';
import 'package:mobile_frontend/features/consumer/reviews/presentation/widgets/Review.dart';
import 'package:mobile_frontend/features/consumer/core/widgets/button.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: const CommonAppBar(
        title: "Reviews",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    Text(
                      '245 Reviews',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text('4.8'),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star_rounded,
                                color: Colors.amber, size: 18),
                            Icon(Icons.star_rounded,
                                color: Colors.amber, size: 18),
                            Icon(Icons.star_rounded,
                                color: Colors.amber, size: 18),
                            Icon(Icons.star_rounded,
                                color: Colors.amber, size: 18),
                            Icon(Icons.star_border_rounded,
                                color: Colors.amber, size: 18),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                ColoredButton(
                  label: "Add",
                  onPressed: () {
                    Navigator.pushNamed(context, '/addreview');
                  },
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const ListTile(
                        contentPadding: EdgeInsets.zero, title: Review());
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        onCartTap: () {},
      ),
    );
  }
}

import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20)),
          child: Image.asset(
            "assets/images/cloth_3.png",
            width: 80,
            height: 80,
          ),
        ),
        const SizedBox(width: 16),
        const SizedBox(
          width: 230,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Casual Men Outfit',
                style: TextStyle(fontSize: 17),
              ),
              Text(
                'From Collection of Men Outfit in Iowa Bundle',
                style: TextStyle(fontSize: 12, color: Color(0xFF5C5F6A)),
              ),
              Text(
                '\$2400.99',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
      ],
    );
  }
}

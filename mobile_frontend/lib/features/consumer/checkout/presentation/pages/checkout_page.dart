import 'package:flutter/material.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';
import 'package:mobile_frontend/features/consumer/checkout/domain/entities/checkout.dart';
import 'package:mobile_frontend/features/consumer/core/widgets/button.dart';

class CheckoutPage extends StatefulWidget {
  final Checkout checkoutData;

  const CheckoutPage({super.key, required this.checkoutData});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final Color accent = Theme.of(context).colorScheme.tertiary;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Checkout',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(onCartTap: () {}),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Address Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: accent,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No Address Provided',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          Text('No Contact Info'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Shipping Service', '0.0'),
                    const Divider(),
                    _buildInfoRow('Issue Invoice', 'No Invoice'),
                    const Divider(),
                    _buildInfoRow('Order Notes', 'No Notes'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Price Details Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPriceRow('Original Price',
                        '\$${widget.checkoutData.totalAmount ?? '0.00'}'),
                    _buildPriceRow('Fee',
                        '\$${widget.checkoutData.platformFee ?? '0.00'}'),
                    const Divider(),
                    _buildPriceRow(
                      'Total',
                      '\$${widget.checkoutData.netPayable ?? '0.00'}',
                      isBold: true,
                      color: accent,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              PrimaryButton(
                  label: 'Confirm',
                  onPressed: () =>
                      Navigator.pushNamed(context, '/consumermarketplace'))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPriceRow(String title, String value,
      {bool isBold = false, Color color = Colors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
              fontSize: title == 'Total' ? 23 : null),
        ),
        Text(
          value,
          style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
              fontSize: title == 'Total' ? 23 : null),
        ),
      ],
    );
  }
}

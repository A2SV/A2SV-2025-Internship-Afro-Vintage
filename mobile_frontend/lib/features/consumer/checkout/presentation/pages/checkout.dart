import 'package:flutter/material.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';
import 'package:mobile_frontend/features/consumer/core/widgets/button.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final List<Map<String, dynamic>> fakeCartItems = [
    {
      'name': 'Casual Men Outfit',
      'description': 'From Collection of Men Outfit in Iowa Bundle',
      'price': 2400.99,
      'image': 'assets/images/cloth_3.png',
    },
    {
      'name': 'Elegant Women Dress',
      'description': 'From Collection of Women Outfit in California Bundle',
      'price': 3200.50,
      'image': 'assets/images/cloth_2.png',
    },
    {
      'name': 'Classic Leather Jacket',
      'description': 'From Collection of Premium Jackets in New York',
      'price': 4500.00,
      'image': 'assets/images/cloth_1.png',
    },
  ];

  void _showPaymentSuccessDialog() {
    final Color secondary = Theme.of(context).colorScheme.secondary;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: secondary,
                size: 60,
              ),
              const SizedBox(height: 16),
              const Text(
                'PAYMENT SUCCESS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your payment was successful',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Payment ID 15263541',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/consumermarketplace');
                },
                child: const Text('BACK TO HOME'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color accent = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Add Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
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
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '456 Creative Lane San Francisco, CA 94102, United States',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          SizedBox(height: 5),
                          Text('Starry Sa  (+1) ***-***-1234'),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/addaddress');
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 16,
                        color: accent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dauphin Pastoureau',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                  const Text(
                    "Pending payment",
                    style: TextStyle(
                      color: Color(0xFFFF8039),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ...fakeCartItems
                  .map((item) => _buildCartItem(item['name']))
                  .toList(),
              const SizedBox(height: 20),

              // Shipping and Notes Section
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
                    _buildInfoRow('Shipping Service', 'Estimated 3 mins'),
                    const Divider(),
                    _buildInfoRow('Issue Invoice', 'No Invoice This Time'),
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
                    _buildPriceRow('Original Price', '\$41.98'),
                    _buildPriceRow('Fee', '-\$0.20'),
                    _buildPriceRow('Shipping Cost', '\$0.04'),
                    const Divider(),
                    _buildPriceRow('Order ID', '353255655555578'),
                    _buildPriceRow('Created At', '2024-03-04 11:40:52'),
                    const Divider(),
                    _buildPriceRow(
                      'Total',
                      '\$41.98',
                      isBold: true,
                      color: accent,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              PrimaryButton(
                label: "Pay Now",
                onPressed: _showPaymentSuccessDialog,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem(String itemName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  "assets/images/cloth_3.png",
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 190,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemName,
                      style: const TextStyle(fontSize: 17),
                    ),
                    const Text(
                      'From Collection of Men Outfit in Iowa Bundle',
                      style: TextStyle(fontSize: 12, color: Color(0xFF5C5F6A)),
                    ),
                    const Text(
                      '\$2400.99',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ],
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

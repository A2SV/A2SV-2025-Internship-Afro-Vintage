import 'package:flutter/material.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/domain/entities/order.dart';

class OrderDetailPage extends StatelessWidget {
  final Order order;
  final String contactName;
  final bool isBoughtOrder;

  const OrderDetailPage({
    super.key,
    required this.order,
    required this.contactName,
    required this.isBoughtOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${order.id}'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Status Banner
            Container(
              width: double.infinity,
              color: order.status.toLowerCase() == 'completed' 
                  ? Colors.green[100] 
                  : Colors.orange[100],
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    order.status.toLowerCase() == 'completed'
                        ? Icons.check_circle
                        : Icons.pending,
                    color: order.status.toLowerCase() == 'completed'
                        ? Colors.green
                        : Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    order.status,
                    style: TextStyle(
                      color: order.status.toLowerCase() == 'completed'
                          ? Colors.green
                          : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Order Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    title: 'Order Information',
                    children: [
                      _buildDetailRow('Order ID', order.id),
                      _buildDetailRow('Date', order.createdAt.toLocal().toString().split(' ')[0]),
                      _buildDetailRow('Total Price', '\$${order.totalPrice.toStringAsFixed(2)}'),
                      _buildDetailRow('Platform Fee', '\$${order.platformFee.toStringAsFixed(2)}'),
                      if (order.productIds != null && order.productIds!.isNotEmpty)
                        _buildDetailRow('Number of Items', order.productIds!.length.toString()),
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildSection(
                    title: isBoughtOrder ? 'Supplier Information' : 'Consumer Information',
                    children: [
                      _buildDetailRow('Name', contactName),
                      // Add more contact details if available
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildSection(
                    title: 'Bundle Information',
                    children: [
                      _buildDetailRow('Bundle ID', order.bundleId),
                      // Add more bundle details if available
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Contact Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showContactDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF008080),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Contact ${isBoughtOrder ? 'Supplier' : 'Consumer'}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
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
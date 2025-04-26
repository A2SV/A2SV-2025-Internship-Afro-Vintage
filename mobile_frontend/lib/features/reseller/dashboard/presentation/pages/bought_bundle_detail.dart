import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/features/reseller/unpack/presentation/pages/unpack_bundle_page.dart';
import '../../domain/entities/dashboard_metrics.dart';

class BoughtBundleDetail extends StatelessWidget {
  final BoughtBundle bundle;

  const BoughtBundleDetail({
    super.key,
    required this.bundle,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image with back button overlaid
            Stack(
              children: [
                // Image
                SizedBox(
                  width: screenWidth,
                  height: 300,
                  child: Image.network(
                    bundle.sampleImage,
                    fit: BoxFit.cover,
                  ),
                ),

                // Back Button
                Positioned(
                  top: 16,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.arrow_back,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Bundle details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          bundle.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildStatusBadge(bundle.status),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Price
                  Text(
                    '\$${bundle.price}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF008080),
                    ),
                  ),

                  const SizedBox(height: 25),
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    bundle.description,
                    style: const TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.28,
                      height: 1.78,
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Additional Details
                  _buildDetailRow('Type', bundle.type),
                  _buildDetailRow('Grade', bundle.grade),
                  _buildDetailRow('Sorting Level', bundle.sortingLevel),
                  _buildDetailRow('Items',
                      '${bundle.remainingItemCount}/${bundle.quantity}'),
                  _buildDetailRow('Rating', bundle.declaredRating.toString()),

                  const SizedBox(height: 20),
                  // Estimated Breakdown
                  const Text(
                    'Estimated Breakdown',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildBreakdownList(bundle.estimatedBreakdown),

                  const SizedBox(height: 30),
                  // Unpack Button
                  _buildUnpackButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final isShipped = status.toLowerCase() == 'shipped';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isShipped ? Colors.green[100] : Colors.blue[100],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isShipped ? Colors.green : Colors.blue[800],
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownList(Map<String, int> breakdown) {
    return Column(
      children: breakdown.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                entry.key,
                style: const TextStyle(fontSize: 13),
              ),
              Text(
                '${entry.value} items',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUnpackButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: bundle.remainingItemCount > 0
            ? () {
                // TODO: Implement unpack functionality
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Unpack Bundle'),
                    content: Text(
                        'Are you sure you want to unpack ${bundle.title}?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: Implement unpack logic
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UnpackBundlePage(
                                bundle: bundle,
                                remainingItems: bundle.remainingItemCount,
                              ),
                            ),
                          );
                        },
                        child: const Text('Unpack'),
                      ),
                    ],
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF008080),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          bundle.remainingItemCount > 0
              ? 'Unpack Bundle'
              : 'No Items Remaining',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

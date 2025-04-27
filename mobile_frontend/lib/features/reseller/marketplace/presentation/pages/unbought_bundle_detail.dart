import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/bundle.dart';
import '../blocs/marketplace_bloc.dart';
import '../blocs/marketplace_event.dart';
import '../blocs/marketplace_state.dart';
import '../blocs/payment/payment_bloc.dart';
import 'payment_confirmation_page.dart';

class UnboughtBundleDetail extends StatelessWidget {
  final Bundle bundle;

  const UnboughtBundleDetail({
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: bundle.status.toLowerCase() == 'available'
                              ? Colors.green[100]
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          bundle.status,
                          style: TextStyle(
                            color: bundle.status.toLowerCase() == 'available'
                                ? Colors.green
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Text(
                      bundle.description,
                      style: const TextStyle(
                        fontSize: 13,
                        letterSpacing: 0.28,
                        height: 1.78,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Type and Quantity
                  Row(
                    children: [
                      const Text(
                        'Type',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 100),
                      const Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          '• ${bundle.type}',
                          style: const TextStyle(
                            fontSize: 13,
                            letterSpacing: 0.28,
                          ),
                        ),
                        const SizedBox(width: 30),
                        Text(
                          '• ${bundle.remainingItemCount}/${bundle.quantity} items',
                          style: const TextStyle(
                            fontSize: 13,
                            letterSpacing: 0.28,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),
                  // Purchase button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: bundle.status.toLowerCase() == 'available'
                          ? () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => PaymentBloc(),
                                    child: PaymentConfirmationPage(
                                      bundle: bundle,
                                    ),
                                  ),
                                ),
                              );

                              if (result == true) {
                                // Payment was successful, refresh the marketplace
                                if (context.mounted) {
                                  context
                                      .read<MarketplaceBloc>()
                                      .add(LoadBundles());
                                  Navigator.pop(
                                      context); // Go back to marketplace
                                }
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF008080),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        bundle.status.toLowerCase() == 'available'
                            ? 'Buy Bundle'
                            : 'Not Available',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
}

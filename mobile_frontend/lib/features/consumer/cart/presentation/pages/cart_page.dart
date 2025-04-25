import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_bloc.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_event.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_state.dart';
import 'package:mobile_frontend/features/consumer/checkout/domain/entities/checkout.dart';
import 'package:mobile_frontend/features/consumer/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:mobile_frontend/features/consumer/checkout/presentation/bloc/checkout_event.dart';
import 'package:mobile_frontend/features/consumer/checkout/presentation/bloc/checkout_state.dart';
import 'package:mobile_frontend/features/consumer/checkout/presentation/pages/checkout_page.dart';
import 'package:mobile_frontend/features/consumer/core/widgets/button.dart';

class CartBottomSheet extends StatelessWidget {
  final Function(String) onCartToggle;

  const CartBottomSheet({
    super.key,
    required this.onCartToggle,
  });

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).primaryColor;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    // Dispatch FetchCartEvent when the widget is built
    context.read<CartBloc>().add(FetchCartEvent());

    return BlocListener<CheckoutBloc, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutSuccess) {
          // Show the payment success dialog
          _showPaymentSuccessDialog(context, state.data);
        } else if (state is CheckoutError) {
          // Show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16),
            height:
                MediaQuery.of(context).size.height * 0.6, // Bottom sheet height
            child: state is Loading
                ? const Center(
                    child: CircularProgressIndicator()) // Loading indicator
                : state is Success && state.data is List
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your Cart',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: (state.data as List).isEmpty
                                ? const Center(
                                    child: Text('Your cart is empty'))
                                : ListView.builder(
                                    itemCount: (state.data as List).length,
                                    itemBuilder: (context, index) {
                                      final cartItems = state.data as List;
                                      return CartCard(
                                        cartName: cartItems[index].title,
                                        onCartToggle: onCartToggle,
                                        price: cartItems[index].price,
                                        imageURL: cartItems[index].imageURL,
                                        id: cartItems[index].listing_id,
                                      );
                                    },
                                  ),
                          ),
                          const SizedBox(height: 24),
                          if ((state.data as List).isNotEmpty)
                            PrimaryButton(
                              label: 'Buy Now',
                              onPressed: () {
                                context
                                    .read<CheckoutBloc>()
                                    .add(PerformCheckoutEvent());
                              },
                            )
                        ],
                      )
                    : state is Error
                        ? Center(
                            child:
                                Text('Failed to load cart: ${state.message}'),
                          )
                        : const Center(child: Text('Your cart is empty')),
          );
        },
      ),
    );
  }
}

class CartCard extends StatefulWidget {
  final String cartName;
  final double price;
  final String? imageURL;
  final String id;
  final Function(String) onCartToggle;

  const CartCard({
    super.key,
    required this.cartName,
    required this.onCartToggle,
    required this.price,
    this.imageURL,
    required this.id,
  });

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  bool _isInCart = false;
  void _removeFromCart() {
    context
        .read<CartBloc>()
        .add(RemoveFromCartEvent(productId: widget.id.toString()));
  }

  void _toggleCart() {
    setState(() {
      _isInCart = !_isInCart;
    });
    widget.onCartToggle(widget.cartName);
  }

  @override
  Widget build(BuildContext context) {
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
                child: widget.imageURL != null && widget.imageURL!.isNotEmpty
                    ? Image.network(
                        widget.imageURL!,
                        width: 80,
                        height: 80,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback to asset image if network image fails
                          return Image.asset(
                            "assets/images/cloth_3.png",
                            width: 80,
                            height: 80,
                          );
                        },
                      )
                    : Image.asset(
                        "assets/images/cloth_3.png", // Default asset image
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
                      widget.cartName,
                      style: const TextStyle(fontSize: 17),
                    ),
                    Text(
                      '\$${widget.price}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
              onPressed: _removeFromCart,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ],
      ),
    );
  }
}

void _showPaymentSuccessDialog(BuildContext context, Checkout checkoutData) {
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
            const SizedBox(height: 16),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutPage(
                        checkoutData:
                            checkoutData // Convert checkoutData to Map<String, dynamic>
                        ),
                  ),
                );
              },
              child: const Text('GO TO CHECKOUT'),
            ),
          ],
        ),
      );
    },
  );
}

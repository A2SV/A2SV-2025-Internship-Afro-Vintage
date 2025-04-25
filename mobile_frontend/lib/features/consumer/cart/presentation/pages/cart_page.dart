import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_bloc.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_event.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_state.dart';

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

    return BlocBuilder<CartBloc, CartState>(
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
                              ? const Center(child: Text('Your cart is empty'))
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
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$ 1,999.99",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/addaddress');
                                  },
                                  child: const Text(
                                    "Buy Now",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : state is Error
                      ? Center(
                          child: Text('Failed to load cart: ${state.message}'),
                        )
                      : const Center(child: Text('Your cart is empty')),
        );
      },
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
    // Dispatch the RemoveFromCartEvent

    // print("WTFFFFFFFFFFFFF: ${widget.id}");
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

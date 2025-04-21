import 'package:flutter/material.dart';

class CartBottomSheet extends StatelessWidget {
  final List<String> cartItems;
  final Function(String) onCartToggle;
  const CartBottomSheet({
    super.key,
    required this.cartItems,
    required this.onCartToggle,
  });

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).primaryColor;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Cart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: cartItems.isEmpty
                ? const Center(child: Text('Your cart is empty'))
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return CartCard(
                        cartName: cartItems[index],
                        onCartToggle: onCartToggle,
                      );
                    },
                  ),
          ),
          const SizedBox(height: 24),
          Material(
            elevation: 5, // Shadow elevation
            borderRadius: BorderRadius.circular(50), // Rounded corners
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
                      color: primary,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: secondary,
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
      ),
    );
  }
}

class CartCard extends StatefulWidget {
  final String cartName;
  final Function(String) onCartToggle;

  const CartCard({
    super.key,
    required this.cartName,
    required this.onCartToggle,
  });

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  bool _isInCart = false;
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
                      widget.cartName,
                      style: const TextStyle(fontSize: 17),
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
              onPressed: _toggleCart,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ],
      ),
    );
  }
}

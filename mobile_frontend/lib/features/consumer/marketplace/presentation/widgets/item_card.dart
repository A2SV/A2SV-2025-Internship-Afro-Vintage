import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final String itemName;
  final String itemPrice;
  final Function(String) onCartToggle;

  const ItemCard({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.onCartToggle,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool _isInCart = false;

  void _toggleCart() {
    setState(() {
      _isInCart = !_isInCart;
    });
    widget.onCartToggle(widget.itemName);
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/productdetail');
          },
          child: SizedBox(
            width: 300,
            height: 300,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/cloth_3.png",
                      width: 300,
                      height: 200,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.itemName,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.itemPrice,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_rate_rounded,
                          color: Color(0xFFFFA439),
                        ),
                        Text(
                          '4.8',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: Icon(
              _isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
              color: _isInCart ? primary : const Color(0xFF8F959E),
            ),
            onPressed: _toggleCart,
          ),
        ),
      ],
    );
  }
}

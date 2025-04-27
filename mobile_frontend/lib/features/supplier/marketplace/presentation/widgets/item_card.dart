import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final String itemId;
  final String itemName;
  final String itemPrice;
  final String itemDescription;
  final Function(String) onCartToggle;
  final int declaredRating;

  const ItemCard({
    super.key,
    required this.itemId,
    required this.itemName,
    required this.itemPrice,
    required this.itemDescription,
    required this.onCartToggle,
    required this.declaredRating,
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
            Navigator.pushNamed(
              context,
              '/supplierproductdetail',
              arguments: {'bundleId': widget.itemId},
            );
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
                      'assets/images/cloth_2.png',
                      width: 300,
                      height: 200,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  // Show product description instead of title
                  widget.itemDescription,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // Remove Naira sign, only show dollar sign and price
                      '\$${widget.itemPrice.replaceAll('₦', '')}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star_rate_rounded,
                          color: Color(0xFFFFA439),
                        ),
                        Text(
                          '${widget.declaredRating}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
            icon: const Icon(
              Icons.edit,
              color: Color(0xFF8F959E),
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/editproduct',
                arguments: {'bundleId': widget.itemId},
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_event.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_state.dart';
import 'package:mobile_frontend/features/consumer/marketplace/domain/entities/product.dart';
import 'package:mobile_frontend/features/consumer/product_detail/presentation/pages/product_detail.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';

class ItemCard extends StatefulWidget {
  final Product product;
  final double cardWidth;

  const ItemCard({super.key, required this.product, required this.cardWidth});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool _isInCart = false;

  void _toggleCart() {
    setState(() {
      _isInCart = !_isInCart;
    });

    final cartBloc = context.read<CartBloc>();
    if (_isInCart) {
      // Add to cart
      cartBloc.add(AddToCartEvent(productId: widget.product.id));
    } else {
      // Remove from cart
      cartBloc.add(RemoveFromCartEvent(productId: widget.product.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    print("Imageeeeeeeeeee ${widget.product.image_url}");
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is Success) {
          print(state.data);
        } else if (state is Error) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add to cart: ${state.message}')),
          );
        }
      },
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                            product: widget.product,
                          )));
            },
            child: SizedBox(
              width: widget.cardWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: widget.product.image_url != null
                          ? (widget.product.image_url.startsWith('http')
                              ? Image.network(
                                  widget.product.image_url,
                                  width: widget.cardWidth,
                                  height: 180,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.network(
                                      "https://www.ever-pretty.com/cdn/shop/products/ES01750TE-R.jpg",
                                      width: widget.cardWidth,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : (RegExp(r'^[A-Za-z0-9+/=]+$').hasMatch(
                                      widget.product.image_url.split(',').last)
                                  ? Image.memory(
                                      base64Decode(widget.product.image_url
                                          .split(',')
                                          .last),
                                      width: widget.cardWidth,
                                      height: 180,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.network(
                                          "https://www.ever-pretty.com/cdn/shop/products/ES01750TE-R.jpg",
                                          width: widget.cardWidth,
                                          height: 180,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                  : Image.network(
                                      "https://www.ever-pretty.com/cdn/shop/products/ES01750TE-R.jpg",
                                      width: widget.cardWidth,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    )))
                          : Image.network(
                              "https://www.ever-pretty.com/cdn/shop/products/ES01750TE-R.jpg",
                              width: widget.cardWidth,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                        Text(
                          widget.product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$ ${widget.product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star_rate_rounded,
                                  color: const Color(0xFFFFA439),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.product.rating.toString(),
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: widget.product.status.toLowerCase() ==
                                    'available'
                                ? Colors.green.withOpacity(0.1)
                                : Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            widget.product.status,
                            style: TextStyle(
                              fontSize: 11,
                              color: widget.product.status.toLowerCase() ==
                                      'available'
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ]))
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
      ),
    );
  }
}

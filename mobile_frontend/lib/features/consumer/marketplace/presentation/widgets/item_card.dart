import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_event.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_state.dart';
import 'package:mobile_frontend/features/consumer/marketplace/domain/entities/product.dart';
import 'package:mobile_frontend/features/consumer/product_detail/presentation/pages/product_detail.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';

class ItemCard extends StatefulWidget {
  final Product product;

  const ItemCard({super.key, required this.product});

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

    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is Success) {
          // Show success message
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text(state.data)),
          // );
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
              width: 300,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: widget.product.image_url != null
                          ? Image.network(
                              widget.product.image_url,
                              width: 300,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "assets/images/cloth_3.png",
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              "assets/images/cloth_3.png",
                              width: 300,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.title,
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$ ${widget.product.price}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star_rate_rounded,
                            color: const Color(0xFFFFA439),
                          ),
                          Text(
                            widget.product.rating.toString(),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_event.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_state.dart';
import 'package:mobile_frontend/features/consumer/marketplace/domain/entities/product.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  double _imageScale = 1.0;
  late TabController _tabController;
  final _unselectedColor = const Color(0xff5f6368);
  late Color primary;
  late Color secondary;

  final List<String> _tabLabels = const ['Description', 'Size'];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabLabels.length, vsync: this);

    _sheetController.addListener(() {
      setState(() {
        _imageScale = 1 - ((_sheetController.size - 0.4) * 0.5);
        _imageScale = _imageScale.clamp(0.7, 1.0);
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showBottomSheet(BuildContext context) {
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          controller: _sheetController,
          expand: false,
          initialChildSize: 0.5,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (_, controller) => DefaultTabController(
            length: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                controller: controller,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://plus.unsplash.com/premium_photo-1690407617542-2f210cf20d7e?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        ),
                        radius: 24,
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.product.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Row(
                            children: [
                              Text(widget.product.type),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.star, size: 16, color: Colors.amber),
                              Text(widget.product.rating.toString())
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  TabBar(
                    tabAlignment: TabAlignment.start,
                    controller: _tabController,
                    isScrollable: true,
                    tabs: _tabLabels.map((label) => Tab(text: label)).toList(),
                    unselectedLabelColor: _unselectedColor,
                    labelColor: Colors.white,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: secondaryColor,
                    ),
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                  ),
                  SizedBox(
                    height: 180,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('• ${widget.product.description}' ??
                                  "• Makanan yang lengkap dan seimbang dengan 41 nutrisi penting."),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Size',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: ['S', 'M', 'L', 'XL'].map((size) {
                                  final isSelected = size ==
                                      widget.product
                                          .size; // Compare with product size
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? secondary
                                            : Colors.transparent,
                                        border: Border.all(color: secondary),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      child: Text(
                                        size,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : secondary,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                            "\$ ${widget.product.price}",
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
                              final cartBloc = context.read<CartBloc>();
                              cartBloc.add(
                                  AddToCartEvent(productId: widget.product.id));
                            },
                            child: BlocBuilder<CartBloc, CartState>(
                              builder: (context, state) {
                                if (state is Loading) {
                                  return const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  );
                                }
                                return const Text(
                                  "Add to Cart",
                                  style: TextStyle(color: Colors.white),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Product Size: ${widget.product.size}");
    primary = Theme.of(context).primaryColor;
    secondary = Theme.of(context).colorScheme.secondary;
    final size = MediaQuery.of(context).size;
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is Success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Hello")),
          );
        } else if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget.product.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  const SizedBox(height: 120),
                  Transform.scale(
                    scale: _imageScale,
                    alignment: Alignment.topCenter,
                    child: Hero(
                      tag: "product-image",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          width: size.width * 0.8,
                          height: size.height * 0.4,
                          child: widget.product.image_url != null
                              ? Image.network(
                                  widget.product.image_url,
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.network(
                                      "https://www.ever-pretty.com/cdn/shop/products/ES01750TE-R.jpg",
                                      width: 300,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.network(
                                  "https://www.ever-pretty.com/cdn/shop/products/ES01750TE-R.jpg",
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => _showBottomSheet(context),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 10)
                        ],
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://plus.unsplash.com/premium_photo-1690407617542-2f210cf20d7e?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                            ),
                            radius: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.product.title,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    Text(widget.product.type),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.star,
                                        size: 16, color: Colors.amber),
                                    Text(widget.product.rating.toString())
                                  ],
                                )
                              ],
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_up_outlined,
                            color: secondary,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                left: 10,
                top: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(onCartTap: () {}),
      ),
    );
  }
}

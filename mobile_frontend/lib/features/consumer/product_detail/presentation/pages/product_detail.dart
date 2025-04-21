import 'package:flutter/material.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductDetailPage(),
    );
  }
}

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

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
                  const Row(
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
                          Text("Jake Santiago",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Row(
                            children: [
                              Text("T-shirt "),
                              Icon(Icons.star, size: 16, color: Colors.amber),
                              Text(" 4.9 (2130 reviews)")
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
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "• Makanan yang lengkap dan seimbang dengan 41 nutrisi penting."),
                              SizedBox(height: 8),
                              Text(
                                  "• Mengandung antioksidan (vitamin E dan selenium) untuk sistem kekebalan tubuh yang sehat."),
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: secondary,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      child: const Text(
                                        'S',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: secondary),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      child: Text(
                                        'M',
                                        style: TextStyle(color: secondary),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: secondary),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      child: Text(
                                        'L',
                                        style: TextStyle(color: secondary),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: secondary),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      child: Text(
                                        'XL',
                                        style: TextStyle(color: secondary),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
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
                            onPressed: () {},
                            child: const Text(
                              "Add to Cart",
                              style: TextStyle(color: Colors.white),
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
    primary = Theme.of(context).primaryColor;
    secondary = Theme.of(context).colorScheme.secondary;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.center,
                  child: Text("T-ShiRT",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                const SizedBox(height: 120),
                Transform.scale(
                  scale: _imageScale,
                  alignment: Alignment.topCenter,
                  child: Hero(
                    tag: "product-image",
                    child: SizedBox(
                      width: size.width * 0.8,
                      height: size.height * 0.4,
                      child: Image.asset(
                        "assets/images/cloth_3.png",
                        width: 300,
                        height: 200,
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
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Jake Santiago",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  Text("T-shirt "),
                                  Icon(Icons.star,
                                      size: 16, color: Colors.amber),
                                  Text(" 4.9 (2130 reviews)")
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
    );
  }
}

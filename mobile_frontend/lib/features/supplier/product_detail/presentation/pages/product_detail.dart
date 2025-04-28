import 'package:flutter/material.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';
import '../../../../../../core/network/api_service.dart';
import '../../data/repositories/bundle_detail_repository.dart';
import '../../data/models/bundle_detail_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductDetailPage(bundleId: ''),
    );
  }
}

class ProductDetailPage extends StatefulWidget {
  final String bundleId;
  const ProductDetailPage({super.key, required this.bundleId});

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
  late BundleDetailRepository _repository;
  BundleDetailModel? _bundle;
  bool _loading = true;
  String? _error;
  bool _removing = false;

  final List<String> _tabLabels = const ['Description', 'Details'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabLabels.length, vsync: this);
    _repository = BundleDetailRepository(api: ApiService());
    _fetchBundleDetail();

    _sheetController.addListener(() {
      setState(() {
        _imageScale = 1 - ((_sheetController.size - 0.4) * 0.5);
        _imageScale = _imageScale.clamp(0.7, 1.0);
      });
    });
  }

  Future<void> _fetchBundleDetail() async {
    setState(() { _loading = true; _error = null; });
    try {
      final bundle = await _repository.fetchBundleDetail(widget.bundleId);
      setState(() {
        _bundle = bundle;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showBottomSheet(BuildContext context) {
    if (_bundle == null) return;
    
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
                        backgroundImage: const AssetImage("assets/images/cloth_3.png"),
                        radius: 24,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_bundle!.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Row(
                            children: [
                              Text(_bundle!.type),
                              const SizedBox(width: 10),
                              const Icon(Icons.star, size: 16, color: Colors.amber),
                              Text('${_bundle!.declaredRating}%')
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
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('• ${_bundle!.description}'),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow('Grade', _bundle!.grade),
                              _buildDetailRow('Quantity', _bundle!.quantity.toString()),
                              _buildDetailRow('Sorting Level', _bundle!.sortingLevel),
                              _buildDetailRow('Size Range', _bundle!.sizeRange),
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Colors.red,
                            ),
                            onPressed: _removing ? null : () async {
                              setState(() { _removing = true; });
                              print('Attempting to delete bundle: \\${_bundle!.id}');
                              try {
                                final msg = await _repository.deleteBundle(_bundle!.id);
                                print('Delete response: \\${msg}');
                                if (mounted) {
                                  Navigator.of(context).pop(); // Close modal
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(msg)),
                                  );
                                  Future.delayed(const Duration(milliseconds: 200), () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamedAndRemoveUntil('/mywarehouse', (route) => false);
                                  });
                                }
                              } catch (e) {
                                print('Delete error: \\${e}');
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Failed to remove bundle: '
                                        + e.toString())),
                                  );
                                }
                              } finally {
                                if (mounted) setState(() { _removing = false; });
                              }
                            },
                            child: _removing
                                ? const SizedBox(
                                    width: 20, height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white, strokeWidth: 2))
                                : const Text(
                                    "Remove",
                                    style: TextStyle(color: Colors.white),
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
                              Navigator.pushNamed(
                                context,
                                '/editbundle',
                                arguments: {'bundleId': _bundle!.id},
                              );
                            },
                            child: const Text(
                              "Edit Bundle",
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    primary = Theme.of(context).primaryColor;
    secondary = Theme.of(context).colorScheme.secondary;
    final size = MediaQuery.of(context).size;

    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        body: Center(child: Text('Error: $_error')),
      );
    }

    if (_bundle == null) {
      return const Scaffold(
        body: Center(child: Text('Bundle not found')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Text(_bundle!.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                const SizedBox(height: 120),
                Transform.scale(
                  scale: _imageScale,
                  alignment: Alignment.topCenter,
                  child: Hero(
                    tag: "bundle-image-${_bundle!.id}",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        width: size.width * 0.8,
                        height: size.height * 0.4,
                        child: Image.asset(
                          "assets/images/cloth_3.png",
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
                        CircleAvatar(
                          backgroundImage: const AssetImage("assets/images/cloth_3.png"),
                          radius: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_bundle!.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  Text(_bundle!.type),
                                  const SizedBox(width: 10),
                                  const Icon(Icons.star,
                                      size: 16, color: Colors.amber),
                                  Text('${_bundle!.declaredRating}%')
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

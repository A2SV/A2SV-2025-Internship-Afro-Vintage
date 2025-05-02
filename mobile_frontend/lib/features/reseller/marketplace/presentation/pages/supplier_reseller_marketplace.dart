import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/core/widgets/common_app_bar.dart';
import 'package:mobile_frontend/core/widgets/side_menu.dart';
import 'package:mobile_frontend/features/reseller/marketplace/domain/entities/bundle.dart';
import 'package:mobile_frontend/features/reseller/marketplace/presentation/blocs/marketplace_bloc.dart';
import 'package:mobile_frontend/features/reseller/marketplace/presentation/blocs/marketplace_event.dart';
import 'package:mobile_frontend/features/reseller/marketplace/presentation/blocs/marketplace_state.dart';
import 'package:mobile_frontend/features/reseller/marketplace/presentation/pages/unbought_bundle_detail.dart';

class SupplierResellerMarketPlacePage extends StatelessWidget {
  const SupplierResellerMarketPlacePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Load bundles when page is first opened
    context.read<MarketplaceBloc>().add(LoadBundles());

    return Scaffold(
      drawer: SideMenu(),
      appBar: CommonAppBar(title: 'View Bundles'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Header(),
              const SizedBox(height: 25),
              const SearchSection(),
              const SizedBox(height: 25),
              const Text(
                'Recommended Bundles',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<MarketplaceBloc, MarketplaceState>(
                builder: (context, state) {
                  if (state is MarketplaceLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF008080),
                      ),
                    );
                  } else if (state is MarketplaceLoaded) {
                    return const BundleCards();
                  } else if (state is MarketplaceError) {
                    return Center(
                      child: Column(
                        children: [
                          Text('Error: ${state.message}'),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<MarketplaceBloc>()
                                  .add(LoadBundles());
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ... Header and SearchSection remain the same ...

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //menu icon
        IconButton(
          icon: const Icon(Icons.menu, size: 24),
          onPressed: () {
            // Handle menu button press
          },
        ),

        Center(
          child: const Text(
            'View Bundles',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),

        Row(
          children: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications, size: 30),
                  onPressed: () {
                    // Handle notification button press
                  },
                ),
                Positioned(
                  top: 3,
                  right: 3,
                  child: Container(
                    height: 19,
                    width: 19,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC53030),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80',
                  ),
                  radius: 24,
                ),
                Positioned(
                  bottom: 2,
                  right: 4,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFF54D62C),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              showSearch(
                context: context,
                delegate: BundleSearchDelegate(context.read<MarketplaceBloc>()),
              );
            },
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(146, 146, 146, 0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(
                    'Search Bundle',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Filter icon container
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF008080).withOpacity(0.17),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.tune, // Filter icon
            color: Color(0xFF5C5F6A),
            size: 20,
          ),
        ),
      ],
    );
  }
}

class BundleCards extends StatelessWidget {
  const BundleCards({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 48) / 2;

    return BlocBuilder<MarketplaceBloc, MarketplaceState>(
      builder: (context, state) {
        if (state is MarketplaceLoaded) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: cardWidth / 290,
            ),
            itemCount: state.bundles.length,
            itemBuilder: (context, index) {
              final bundle = state.bundles[index];
              return BundleCard(
                bundle: bundle,
                cardWidth: cardWidth,
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

class BundleCard extends StatelessWidget {
  final Bundle bundle;
  final double cardWidth;

  const BundleCard({
    super.key,
    required this.bundle,
    required this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // In your BundleCard or wherever you handle bundle tap
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UnboughtBundleDetail(
              bundle: bundle, // Pass the bundle object directly
            ),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                bundle.sampleImage,
                width: cardWidth,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: cardWidth,
                    height: 180,
                    color: Colors.grey[200],
                    child: const Icon(Icons.error_outline, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    bundle.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${bundle.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            bundle.declaredRating.toString(),
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: bundle.status.toLowerCase() == 'available'
                          ? Colors.green.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      bundle.status,
                      style: TextStyle(
                        fontSize: 11,
                        color: bundle.status.toLowerCase() == 'available'
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BundleSearchDelegate extends SearchDelegate {
  final MarketplaceBloc marketplaceBloc;

  BundleSearchDelegate(this.marketplaceBloc);

  @override
  Widget buildResults(BuildContext context) {
    marketplaceBloc.add(SearchBundlesEvent(searchQuery: query));
    return BlocBuilder<MarketplaceBloc, MarketplaceState>(
      bloc: marketplaceBloc,
      builder: (context, state) {
        if (state is MarketplaceLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Color(0xFF008080),
          ));
        } else if (state is MarketplaceLoaded) {
          return ListView.builder(
            itemCount: state.bundles.length,
            itemBuilder: (context, index) {
              final bundle = state.bundles[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    bundle.sampleImage,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(bundle.title),
                subtitle: Text('\$${bundle.price.toStringAsFixed(2)}'),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: bundle.status.toLowerCase() == 'available'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(bundle.status),
                ),
                onTap: () {
                  marketplaceBloc.add(LoadBundleDetails(bundleId: bundle.id));
                  Navigator.pop(context);
                  // TODO: Navigate to bundle details page
                },
              );
            },
          );
        }
        return const Center(child: Text('No results found'));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 2) {
      marketplaceBloc.add(SearchBundlesEvent(searchQuery: query));
      return buildResults(context);
    }
    return const Center(child: Text('Type at least 3 characters to search'));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }
}

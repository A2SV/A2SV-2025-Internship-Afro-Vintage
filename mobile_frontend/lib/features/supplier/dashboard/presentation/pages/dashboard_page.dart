import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/header.dart';
import '../widgets/text_section.dart';
import '../widgets/dashboard_card1.dart';
import '../widgets/dashboard_card2.dart';
import '../widgets/dashboard_card3.dart';
import '../widgets/dashboard_card4.dart';
import '../widgets/bundle_card.dart';
import '../../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../../core/widgets/side_menu.dart';
import '../../../../../core/widgets/search_market.dart';
import '../../../../../core/widgets/common_app_bar.dart';
import '../../../../../core/network/api_service.dart';
import '../../data/models/dashboard_data.dart';
import '../blocs/dashboard_bloc.dart';
import '../blocs/dashboard_event.dart';
import '../blocs/dashboard_state.dart';
import '../../data/repositories/dashboard_repository.dart';

class SupplierDashboardPage extends StatefulWidget {
  const SupplierDashboardPage({super.key});

  @override
  State<SupplierDashboardPage> createState() => _SupplierDashboardPageState();
}

class _SupplierDashboardPageState extends State<SupplierDashboardPage> {
  late DashboardBloc _dashboardBloc;

  @override
  void initState() {
    super.initState();
    final apiService = ApiService();
    _dashboardBloc = DashboardBloc(DashboardRepository(api: apiService));
    _dashboardBloc.add(LoadDashboard());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dashboardBloc.add(LoadDashboard());
  }

  @override
  void dispose() {
    _dashboardBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double aspectRatio = screenWidth > 600 ? 1.5 : 0.8;
    return BlocProvider.value(
      value: _dashboardBloc,
      child: Scaffold(
        appBar: const CommonAppBar(title: 'Dashboard'),
        drawer: const SideMenu(),
        bottomNavigationBar: BottomNavBar(onCartTap: () {}),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DashboardError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is DashboardLoaded) {
              final data = state.data;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      SearchMarket(products: data.activeBundles),
                      const SizedBox(height: 20),
                      const TextSection(),
                      const SizedBox(height: 20),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          double gridHeight = (constraints.maxWidth > 600) ? 350 : 400;
                          return SizedBox(
                            height: gridHeight,
                            child: GridView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 13,
                                mainAxisSpacing: 13,
                                childAspectRatio: aspectRatio,
                              ),
                              children: [
                                DashboardCard1(value: data.activeBundles.length),
                                DashboardCard2(value: data.totalSales),
                                DashboardCard3(
                                  totalBundlesListed: data.totalBundlesListed,
                                  activeCount: data.activeCount,
                                  soldCount: data.soldCount,
                                ),
                                DashboardCard4(rating: data.rating, bestSelling: data.bestSelling),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}

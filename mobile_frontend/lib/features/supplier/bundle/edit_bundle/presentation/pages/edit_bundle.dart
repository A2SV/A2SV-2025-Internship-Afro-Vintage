import 'package:flutter/material.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';
import 'package:mobile_frontend/core/widgets/common_app_bar.dart';
import 'package:mobile_frontend/core/widgets/side_menu.dart';
import '../../../../../../core/network/api_service.dart';
import '../../../create_bundle/presentation/repository/bundle_repository.dart';
import '../widgets/edit_bundle_form.dart';

class EditBundleScreen extends StatelessWidget {
  final String bundleId;
  const EditBundleScreen({Key? key, required this.bundleId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Debug print for bundleId
    print('[DEBUG] EditBundleScreen.bundleId: $bundleId');
    final repository = BundleRepository(api: ApiService());
    return Scaffold(
      drawer: const SideMenu(),
      appBar: const CommonAppBar(title: 'Edit Bundle'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: EditBundleForm(
          repository: repository,
          bundleId: bundleId,
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        onCartTap: () {},
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/network/api_service.dart';
import '../bloc/create_bundle_bloc.dart';
import '../widgets/create_bundle_form.dart';
import '../widgets/image_upload_field.dart';
import '../repository/bundle_repository.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';
import 'package:mobile_frontend/features/consumer/core/widgets/button.dart';
import 'package:mobile_frontend/features/consumer/core/widgets/input.dart';
import 'package:mobile_frontend/core/widgets/common_app_bar.dart';
import 'package:mobile_frontend/core/widgets/side_menu.dart';

class CreateBundleScreen extends StatelessWidget {
  const CreateBundleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: const CommonAppBar(title: 'Create Bundle'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CreateBundleForm(
          repository: BundleRepository(api: ApiService()),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        onCartTap: () {},
      ),
    );
  }
}

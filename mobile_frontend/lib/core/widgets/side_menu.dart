import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  Future<String> _getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role') ?? 'consumer'; // Default to 'consumer'
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error loading role'));
        }

        final role = snapshot.data ?? 'consumer';

        return Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SvgPicture.asset(
                            'assets/logo/AfroVintageLogo.svg',
                            width: 50,
                            height: 40,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(
                                Icons.keyboard_double_arrow_left_outlined,
                                size: 30,
                                color: Color(0xFF8C8787)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    width: 270,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(33, 43, 54, 0.07),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: ClipOval(
                            child: Image.network(
                              "https://plus.unsplash.com/premium_photo-1690407617542-2f210cf20d7e?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Jack Santiago",
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                "Reseller",
                                style: TextStyle(
                                    color: Color(0xFF8C8787), fontSize: 14),
                              )
                            ])
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ..._buildMenuItems(context, role),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildMenuItems(BuildContext context, String role) {
    List<Widget> menuItems = [];

    if (role == 'consumer') {
      menuItems.addAll([
        ListTile(
          leading: const Icon(
            Icons.storefront_rounded,
            color: Color(0xFF8C8787),
          ),
          title: const Text(
            "MarketPlace",
            style: TextStyle(color: Color(0xFF8C8787)),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/consumermarketplace');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.assignment_outlined,
            color: Color(0xFF8C8787),
          ),
          title: const Text(
            "Orders",
            style: TextStyle(color: Color(0xFF8C8787)),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/allorder');
          },
        ),
      ]);
    } else if (role == 'supplier') {
      menuItems.addAll([
        ListTile(
          leading: const Icon(
            Icons.warehouse,
            color: Color(0xFF8C8787),
          ),
          title: const Text(
            "Warehouse",
            style: TextStyle(color: Color(0xFF8C8787)),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/mywarehouse');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.dashboard,
            color: Color(0xFF8C8787),
          ),
          title: const Text(
            "Dashboard",
            style: TextStyle(color: Color(0xFF8C8787)),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/dashboard');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.assignment_outlined,
            color: Color(0xFF8C8787),
          ),
          title: const Text(
            "Orders",
            style: TextStyle(color: Color(0xFF8C8787)),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/allorder');
          },
        ),
      ]);
    } else if (role == 'reseller') {
      menuItems.addAll([
        ListTile(
          leading: const Icon(
            Icons.dashboard,
            color: Color(0xFF8C8787),
          ),
          title: const Text(
            "Dashboard",
            style: TextStyle(color: Color(0xFF8C8787)),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/dashboard');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.storefront_rounded,
            color: Color(0xFF8C8787),
          ),
          title: const Text(
            "Supplier Marketplace",
            style: TextStyle(color: Color(0xFF8C8787)),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/supplier-reseller-marketplace');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.storefront_rounded,
            color: Color(0xFF8C8787),
          ),
          title: const Text(
            "Consumer Marketplace",
            style: TextStyle(color: Color(0xFF8C8787)),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/consumermarketplace');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.assignment_outlined,
            color: Color(0xFF8C8787),
          ),
          title: const Text(
            "My Orders",
            style: TextStyle(color: Color(0xFF8C8787)),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/hello');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.warehouse,
            color: Color(0xFF8C8787),
          ),
          title: const Text(
            "My Warehouse",
            style: TextStyle(color: Color(0xFF8C8787)),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/reseller-warehouse');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.unarchive,
            color: Color(0xFF8C8787),
          ),
          title: const Text(
            "Unpack Bundles",
            style: TextStyle(color: Color(0xFF8C8787)),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/unpackbundles');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.production_quantity_limits,
            color: Color(0xFF8C8787),
          ),
          title: const Text(
            "My Products",
            style: TextStyle(color: Color(0xFF8C8787)),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/myproducts');
          },
        ),
      ]);
    }

    // Add common menu items
    menuItems.addAll([
      ListTile(
        leading: const Icon(
          Icons.star_border_sharp,
          color: Color(0xFF8C8787),
        ),
        title: const Text(
          "Reviews",
          style: TextStyle(color: Color(0xFF8C8787)),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/reviews');
        },
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Divider(),
      ),
      ListTile(
        leading: const Icon(
          Icons.contact_mail,
          color: Color(0xFF8C8787),
        ),
        title: const Text(
          "Contact Us",
          style: TextStyle(color: Color(0xFF8C8787)),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/contactus');
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.settings,
          color: Color(0xFF8C8787),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Color(0xFF8C8787)),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/settings');
        },
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Divider(),
      ),
      ListTile(
        leading: const Icon(
          Icons.logout,
          color: Color(0xFF8C8787),
        ),
        title: const Text(
          "Log Out",
          style: TextStyle(color: Color(0xFF8C8787)),
        ),
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('auth_token');
          await prefs.remove('role');
          Navigator.pushNamedAndRemoveUntil(
              context, '/signin', (route) => false);
        },
      ),
    ]);

    return menuItems;
  }
}

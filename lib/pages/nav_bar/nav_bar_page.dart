import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_flutter_test/constant/color.dart';
import 'package:mx_flutter_test/controller/nav_bar_controller.dart';
import 'package:mx_flutter_test/pages/address/address_page.dart';
import 'package:mx_flutter_test/pages/main_page.dart';
import 'package:mx_flutter_test/pages/order/order_page.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  NavBarController nvb = Get.find();

  final List<NavItem> _navItems = [
    NavItem(PhosphorIcons.houseSimple(), "Home"),
    NavItem(Icons.list_alt, "History"),
    NavItem(PhosphorIcons.userCircle(), "Profile"),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      nvb.changeTabIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: whiteColor,
        surfaceTintColor: whiteColor,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _navItems.map((item) {
            var index = _navItems.indexOf(item);
            return IconButton(
              onPressed: () => _onNavItemTapped(index),
              icon: Icon(
                item.icon,
                color: nvb.tabIndex == index ? primaryColor : blackColor,
              ),
            );
          }).toList(),
        ),
      ),
      body: IndexedStack(
        index: nvb.tabIndex,
        children: const [MainPage(), OrderPage(), AddressPage()],
      ),
    );
  }
}

class NavItem {
  IconData icon;
  String title;

  NavItem(this.icon, this.title);
}

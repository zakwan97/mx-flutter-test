import 'package:get/get.dart';
import 'package:mx_flutter_test/pages/cart_page.dart';
import 'package:mx_flutter_test/pages/main_page.dart';
import 'package:mx_flutter_test/pages/nav_bar/nav_bar_page.dart';
import 'package:mx_flutter_test/pages/order_page.dart';
import 'package:mx_flutter_test/pages/product_detail_page.dart';
import 'package:mx_flutter_test/pages/profile_page.dart';
import 'package:mx_flutter_test/routes/app_routes.dart';
import 'package:mx_flutter_test/splash_screen.dart';

class AppPages {
  static const splashScreen = AppRoutes.splashScreen;
  static final pageList = [
    GetPage(
      name: AppRoutes.splashScreen,
      page: () {
        return const SplashScreen();
      },
    ),
    GetPage(
      name: AppRoutes.navigationBarPage,
      page: () {
        return const NavigationBarPage();
      },
    ),
    GetPage(
      name: AppRoutes.mainPage,
      page: () {
        return const MainPage();
      },
    ),
    GetPage(
      name: AppRoutes.cartPage,
      page: () {
        return const CartPage();
      },
    ),
    GetPage(
      name: AppRoutes.profilePage,
      page: () {
        return const ProfilePage();
      },
    ),
    GetPage(
      name: AppRoutes.productDetails,
      page: () {
        return const ProductDetails();
      },
    ),
    GetPage(
      name: AppRoutes.orderPage,
      page: () {
        return const OrderPage();
      },
    ),
  ];
}

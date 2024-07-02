import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mx_flutter_test/constant/color.dart';
import 'package:mx_flutter_test/controller/nav_bar_controller.dart';
import 'package:mx_flutter_test/routes/app_pages.dart';
import 'package:mx_flutter_test/routes/binding/binding.dart';
import 'package:mx_flutter_test/util/preference.dart';
import 'package:sizer/sizer.dart';

void main() async {
  // enableFlutterDriverExtension();
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => NavBarController(), fenix: true);
  await Preference.init();
  Preference.getBool(Preference.showOnboard) ??
      Preference.setBool(Preference.showOnboard, true);
  Preference.getBool(Preference.isLogin) ??
      Preference.setBool(Preference.isLogin, false);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        builder: (context, child) {
          return Scaffold(
            body: child,
          );
        },
        theme: ThemeData(
          primaryColor: primaryColor,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          useMaterial3: true,
          fontFamily: GoogleFonts.poppins().fontFamily,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: AppPages.splashScreen,
        getPages: AppPages.pageList,
        initialBinding: InitialBinding(),
      );
    });
  }
}

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_flutter_test/constant/color.dart';
import 'package:mx_flutter_test/util/preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = Preference.getBool(Preference.isLogin)!;
  bool showOnboard = Preference.getBool(Preference.showOnboard)!;

  @override
  void initState() {
    super.initState();
    checkInternet();
    // onLoading();
  }

  Future<void> checkInternet() async {
    try {
      final response = await InternetAddress.lookup("www.apple.com")
          .timeout(const Duration(seconds: 10));
      if (response.isNotEmpty) {
        onLoading();
      }
    } on SocketException {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              "Error",
            ),
            content: const Text(
              "Seems like you don't have proper internet connection. Please connect to internet!",
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  checkInternet();
                  Navigator.pop(context);
                },
                child: const Text("Retry"),
              )
            ],
          ),
        );
      }
    }
  }

  redirectPage(int duration) {
    Timer(
      Duration(seconds: duration),
      () {
        // showOnboard
        //     ? Get.offNamed('/welcomePage')
        //     : isLogin
        //         ? Get.offNamed('/navigationBarPage')
        //         : Get.offNamed('/loginPage');
        Get.offNamed('/navigationBarPage');
      },
    );
  }

  onLoading() async {
    redirectPage(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/seven24.png',
              height: 150,
              width: 200,
            ),
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: LinearProgressIndicator(
                color: primaryColor,
                backgroundColor: whiteColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/constants/colors/colors.dart';
import '../../core/constants/images/images.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Get.off(() => const HomeScreen());
        // if (isLoggedIn == true) {
        //   Get.off(() => const LayoutScreen(initalIndex: 0));
        //   // NavigationUtils.navigateToGivenScreen(context, '/layout');
        // } else {
        //   Get.off(() => const LoginScreen());
        //   // NavigationUtils.navigateToGivenScreen(context, '/login');
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // image: DecorationImage(
        //   image: AssetImage(splashBackground),
        //   fit: BoxFit.cover,
        // ),
        color: cMaroon,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                splashLogo,
                semanticsLabel: 'Splash Logo',
                // ignore: deprecated_member_use
                color: cWhite,
                fit: BoxFit.cover,
                height: 400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

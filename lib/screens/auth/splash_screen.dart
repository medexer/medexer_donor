// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/screens/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void runTimeout() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.to(
      transition: Transition.fade,
      duration: const Duration(milliseconds: 500),
      () => const LoginScreen(),
    );
  }

  @override
  void initState() {
    super.initState();

    runTimeout();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash__1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset('assets/images/logo__1.png'),
        ),
      ),
    );
  }
}

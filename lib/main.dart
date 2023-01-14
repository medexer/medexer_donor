// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medexer_donor/database/root_repository.dart';
import 'package:medexer_donor/screens/main/home_screen.dart';
import 'package:medexer_donor/screens/public/login_screen.dart';
import 'package:medexer_donor/screens/public/onboarding_screen.dart';
import 'package:medexer_donor/screens/public/signup_screen.dart';
import 'package:medexer_donor/screens/public/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authStorage = GetStorage();
  final RootRepository rootRepository = Get.put(RootRepository());

  @override
  void initState() {
    super.initState();

    rootRepository.initializeRepositories();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Medexer Donor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto'
      ),
      home: authStorage.read('user') != null ? HomeScreen() : SplashScreen(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/signup', page: () => SignupScreen()),
        GetPage(name: '/onboarding', page: () => OnBoardingScreen()),
      ],
    );
  }
}

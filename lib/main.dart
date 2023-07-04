// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medexer_donor/firebase_options.dart';
import 'package:medexer_donor/config/color_generator_config.dart';
import 'package:medexer_donor/database/root_repository.dart';
import 'package:medexer_donor/network_services/networkBinding.dart';
import 'package:medexer_donor/screens/auth/splash_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/home_screen.dart';
import 'package:medexer_donor/screens/auth/login_screen.dart';
import 'package:medexer_donor/screens/auth/onboarding_screen.dart';
import 'package:medexer_donor/screens/auth/registration/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

    // authStorage.remove('MDX-USER');
    // authStorage.remove('MDX-USER-PROFILE');

    rootRepository.initializeRepositories();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: NetworkBinding(),
      title: 'Medexer Donor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: ColorGenerator.createMaterialColor(Color(0xFF001CF4)),
        fontFamily: 'Poppins',
      ),
      home:
          authStorage.read('MDX-USER') != null ? HomeScreen() : SplashScreen(),
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

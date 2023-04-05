import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

import 'views/screens/home_page.dart';
import 'views/screens/login_page.dart';
import 'views/screens/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash_page",
      getPages: [
        GetPage(name: "/", page: () => const HomePage()),
        GetPage(name: "/splash_page", page: () => const SplashPage()),
        GetPage(name: "/login_page", page: () => const LoginPage()),
      ],
    ),
  );
}

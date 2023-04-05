import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  moveForward() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAndToNamed("/login_page");
  }

  @override
  void initState() {
   moveForward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff1d3557),
      body: Center(
        child: ClipRRect(
          child: Image(
            image: AssetImage("assets/images/Logo.gif"),
            fit: BoxFit.cover,
            height: 280,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashController splashController = Get.put(SplashController());
  SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Welcome to my app',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

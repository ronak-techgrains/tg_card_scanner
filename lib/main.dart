import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tg_card_scan/app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'Tg Card Scanner',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
    ),
  );
}

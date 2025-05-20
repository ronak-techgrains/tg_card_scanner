import 'package:get/get.dart';
import 'package:tg_card_scan/app/modules/scan/views/scan_view.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  @override
  void onInit() {
    goToScanView();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future goToScanView() async {
    await Future.delayed(const Duration(seconds: 3));

    Get.offAll(() => ScanView());
  }
}

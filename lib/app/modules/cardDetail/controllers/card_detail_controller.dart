import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:tg_card_scan/app/utils/card_info_vo.dart';

class CardDetailController extends GetxController {
  CardInfoVo cardInfoVo = CardInfoVo();

  final count = 0.obs;
  Uint8List? imageBytes;
  @override
  void onInit() {
    super.onInit();

    // Access arguments using Get.arguments
    final arguments = Get.arguments;

    if (arguments != null && arguments is Map) {
      cardInfoVo = arguments['cardInfoVo'] ?? CardInfoVo();
      print("cardInfoVocardInfoVo:: ${cardInfoVo.toJson()}");
      getImeageString();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  getImeageString() {
    imageBytes = base64Decode(cardInfoVo.imageString);
    update();
  }
}

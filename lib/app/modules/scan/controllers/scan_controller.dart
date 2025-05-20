import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tg_card_scan/app/utils/card_info_vo.dart';
import 'package:tg_card_scan/app/utils/designations_list.dart';
import 'package:tg_card_scan/app/utils/regex_master.dart';

import '../../cardDetail/views/card_detail_view.dart';

class ScanController extends GetxController {
  final ImagePicker picker = ImagePicker();
  CardInfoVo cardInfoVo = CardInfoVo();
  String extractedText = 'Extracted text will appear here';
  List<String> phones = [];
  String? firstPhone;
  String? secondPhone;
  String? base64Image;

  final count = 0.obs;

  @override
  void onInit() {
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

  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      convertImage(pickedFile);
      readTextFromImage(File(pickedFile.path));
    }
  }

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      convertImage(pickedFile);
      readTextFromImage(File(pickedFile.path));
    }
  }

  Future<void> convertImage(XFile pickedFile) async {
    List<int> imageBytes = await pickedFile.readAsBytes();
    base64Image = base64Encode(imageBytes);
  }

  Future<void> readTextFromImage(File image) async {
    EasyLoading.show(status: 'Processing...');
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    String text = recognizedText.text;
    EasyLoading.dismiss();

    extractedText = text;
    update();

    extractDetailsFromText(text);

    textRecognizer.close();
    EasyLoading.dismiss();
  }

  extractDetailsFromText(String text) {
    final textParts = text.split('\n');
    var name = '';
    var designation = '';
    textParts.asMap().forEach((index, value) {
      if (designation == '' && ListMaster.designations.contains(value)) {
        designation = value;
        if (index > 0) {
          name = textParts[index - 1];
        }
      }
    });
    final emailMatch = RegexMaster.emailRegex.firstMatch(text.trim());
    final phoneMatches = RegexMaster.phoneRegex.allMatches(text.trim());
    final websiteMatch = RegexMaster.websiteRegExp.firstMatch(text.trim().replaceAll(" ", ""));

    phones = phoneMatches
        .where((match) {
          final phoneNumber = match.group(0)!;
          return phoneNumber.replaceAll(RegExp(r'[^0-9]'), '').length > 6;
        })
        .map((match) => match.group(0)!)
        .toSet()
        .toList();
    if (phones.isNotEmpty) {
      if (phones.length >= 2) {
        firstPhone = phones[0];
        secondPhone = phones[1];
      } else {
        firstPhone = phones[0];
      }
    }

    cardInfoVo = CardInfoVo(
        name: name,
        designation: designation,
        email: emailMatch?.group(0) ?? '',
        website: websiteMatch?.group(0) ?? '',
        scanText: extractedText,
        number: firstPhone ?? '',
        secondaryNumber: secondPhone ?? '',
        imageString: base64Image ?? '');

    update();

    print("cardInfoVo::${cardInfoVo.toJson()}");

    Get.to(CardDetailView(), arguments: {'cardInfoVo': cardInfoVo});
    // final email = emailMatch?.group(0) ?? 'No email found';
    //
    // final website = websiteMatch?.group(0) ?? 'No website found';
    //
    // final zipCode = zipCodeMatch?.group(0) ?? 'No zipCode found';
    //
    // final phones = phoneMatches
    //     .where((match) {
    //       final phoneNumber = match.group(0)!;
    //
    //       return phoneNumber.replaceAll(RegExp(r'[^0-9]'), '').length > 6;
    //     })
    //     .map((match) => match.group(0))
    //     .toSet() // Convert to a Set to remove duplicates
    //     .toList(); // Convert back to a List
  }
}

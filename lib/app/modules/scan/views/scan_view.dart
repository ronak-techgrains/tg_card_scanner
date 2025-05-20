import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/scan_controller.dart';

class ScanView extends GetView<ScanController> {
  ScanController scanController = Get.put(ScanController());

  ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScanController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(title: const Text('Business Card Scanner')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: controller.getImageFromCamera,
                child: const Text('Scan Business Card (Camera)'),
              ),
              ElevatedButton(
                onPressed: controller.getImageFromGallery,
                child: const Text('Scan Business Card (Gallery)'),
              ),
              const SizedBox(height: 20),
              Text(
                controller.extractedText,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    });
  }
}

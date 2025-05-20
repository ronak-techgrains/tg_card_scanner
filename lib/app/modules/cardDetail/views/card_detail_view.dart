import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/card_detail_controller.dart';

class CardDetailView extends GetView<CardDetailController> {
  CardDetailController cardDetailController = Get.put(CardDetailController());

  CardDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    cardDetailController.cardInfoVo = Get.arguments['cardInfoVo'];
    cardDetailController.getImeageString();
    return Scaffold(
        appBar: AppBar(
          title: const Text('CardDetailView'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            controller.imageBytes != null
                ? Image.memory(
                    controller.imageBytes!,
                    width: 200, // Adjust width as needed
                    height: 200, // Adjust height as needed
                    fit: BoxFit.cover, // Adjust fit as needed
                  )
                : const Text('No image to display'), // Fallback if no image
            const SizedBox(height: 20),
            Text("Name: ${controller.cardInfoVo.name}"),
            Text("Designation: ${controller.cardInfoVo.designation}"),
            Text("Email: ${controller.cardInfoVo.email}"),
            Text("Phone: ${controller.cardInfoVo.number}"),
            Text("Phone: ${controller.cardInfoVo.secondaryNumber}"),
            Text("Website: ${controller.cardInfoVo.website}"),
          ],
        ));
  }
}

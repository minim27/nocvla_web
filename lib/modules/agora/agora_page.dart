// Instantiate the client
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/modules/agora/agora_controller.dart';
import 'package:nocvla/shared/utils/my_colors.dart';

class AgoraPage extends StatefulWidget {
  const AgoraPage({super.key});

  @override
  State<AgoraPage> createState() => _AgoraPageState();
}

class _AgoraPageState extends State<AgoraPage> {
  final controller = Get.put(AgoraController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.secondary,
      body: SafeArea(
        child: Stack(
          children: [Obx(() => Text("AKU ADALAH ${controller.user.value}"))],
        ),
      ),
    );
  }
}

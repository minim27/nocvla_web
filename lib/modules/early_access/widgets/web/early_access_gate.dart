import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/widgets/my_button.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

import '../../early_access_controller.dart';
import '../early_access_password_dialog.dart';

class EarlyAccessGate extends GetView<EarlyAccessController> {
  const EarlyAccessGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: .symmetric(horizontal: 40, vertical: 32),
          children: [
            SizedBox(height: 56),
            Obx(() => _CountdownRow(remaining: controller.remaining.value)),
            SizedBox(height: 40),
            Obx(
              () => Column(
                children: controller.images
                    .map(
                      (image) => Padding(
                        padding: .only(bottom: 24),
                        child: SizedBox(
                          width: double.infinity,
                          child: MyImage(image.imageUrl, fit: .fitWidth),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        Positioned(
          top: 24,
          right: 40,
          child: MyButton(
            "ENTER USING PASSWORD",
            width: 220,
            height: 40,
            fontSize: 12,
            borderWidth: 1,
            onTap: () => Get.dialog(const EarlyAccessPasswordDialog()),
          ),
        ),
      ],
    );
  }
}

class _CountdownRow extends StatelessWidget {
  const _CountdownRow({required this.remaining});

  final Duration remaining;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        _unit(remaining.inDays.toString().padLeft(2, "0"), "Days"),
        _separator(),
        _unit((remaining.inHours % 24).toString().padLeft(2, "0"), "Hours"),
        _separator(),
        _unit((remaining.inMinutes % 60).toString().padLeft(2, "0"), "Mins"),
        _separator(),
        _unit((remaining.inSeconds % 60).toString().padLeft(2, "0"), "Secs"),
      ],
    );
  }

  Widget _separator() => Padding(
    padding: .symmetric(horizontal: 12),
    child: MyText(text: ":", fontSize: 32, fontWeight: .w300),
  );

  Widget _unit(String value, String label) => Column(
    children: [
      MyText(text: value, fontSize: 32, fontWeight: .w300),
      MyText(text: label, fontSize: 12, color: MyColors.white2),
    ],
  );
}

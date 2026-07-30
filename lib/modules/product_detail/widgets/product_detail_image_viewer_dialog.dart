import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/product_detail/product_detail_controller.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';

class ProductDetailImageViewerDialog extends StatelessWidget {
  const ProductDetailImageViewerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();
    final images = controller.res["images"] as List;
    final pageController = PageController(
      initialPage: controller.selectedImage.value,
    );

    return Container(
      color: MyColors.black.withValues(alpha: 0.95),
      child: Stack(
        children: [
          ScrollConfiguration(
            behavior: _MouseDragScrollBehavior(),
            child: PageView.builder(
              controller: pageController,
              itemCount: images.length,
              onPageChanged: (index) => controller.selectedImage.value = index,
              itemBuilder: (context, index) =>
                  MyImage(images[index], fit: .contain),
            ),
          ),
          Positioned(
            top: 24,
            right: 24,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.close, color: MyColors.white, size: 32),
            ),
          ),
          Positioned(
            left: 24,
            top: 0,
            bottom: 0,
            child: Center(
              child: Obx(
                () => _NavButton(
                  icon: Icons.arrow_back_ios_rounded,
                  enabled: controller.selectedImage.value > 0,
                  onTap: () => pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 24,
            top: 0,
            bottom: 0,
            child: Center(
              child: Obx(
                () => _NavButton(
                  icon: Icons.arrow_forward_ios_rounded,
                  enabled: controller.selectedImage.value < images.length - 1,
                  onTap: () => pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MouseDragScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.trackpad,
  };
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.3,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          width: 48,
          height: 48,
          alignment: .center,
          decoration: BoxDecoration(
            color: MyColors.black2,
            shape: .circle,
          ),
          child: Icon(icon, color: MyColors.white, size: 20),
        ),
      ),
    );
  }
}

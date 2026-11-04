import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/my_colors.dart';
import '../utils/my_fonts.dart';
import 'my_image.dart';
import 'my_text.dart';

class MyButton extends StatelessWidget {
  const MyButton(
    this.text, {
    super.key,
    this.width,
    this.height = 56,
    this.scale = 4,
    this.borderColor,
    this.borderWidth = 0,
    this.color = MyColors.white,
    this.textColor = MyColors.black,
    this.fontSize = 16,
    this.borderRadius = 0,
    this.fontWeight = .w600,
    this.fontFamily = MyFonts.archivoNarrow,
    this.namedArgs,
    this.enable = true,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    required this.onTap,
  });

  final bool enable;
  final double? width;
  final double height, fontSize, borderRadius, borderWidth, scale;
  final String text;
  final String? prefix, suffix;
  final IconData? prefixIcon, suffixIcon;
  final Color color, textColor;
  final Color? borderColor;
  final FontWeight fontWeight;
  final String fontFamily;
  final Map<String, String>? namedArgs;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enable ? onTap : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color.withValues(alpha: enable ? 1 : 0.5),
          borderRadius: .circular(borderRadius),
          border: borderColor == null
              ? null
              : .all(color: borderColor!, width: borderWidth),
        ),
        alignment: .center,
        child: Row(
          spacing: 16,
          mainAxisAlignment: .center,
          children: [
            if (prefix != null) MyImageAssets(prefix!, scale: scale),
            if (prefixIcon != null)
              Icon(prefixIcon, color: textColor, size: fontSize + 2),
            Flexible(
              child: MyText(
                textAlign: .center,
                text: (namedArgs == null)
                    ? text.tr.toUpperCase()
                    : text.tr.trParams(namedArgs!).toUpperCase(),
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
                fontFamily: fontFamily,
                letterSpacing: fontSize * 0.12,
              ),
            ),
            if (suffix != null) MyImageAssets(suffix!, scale: scale),
            if (suffixIcon != null)
              Icon(suffixIcon, color: textColor, size: fontSize + 2),
          ],
        ),
      ),
    );
  }
}

class MyButtonBorder extends StatelessWidget {
  const MyButtonBorder(
    this.text, {
    super.key,
    this.width,
    this.height = 56,
    this.borderColor = MyColors.line,
    this.borderWidth = 1,
    this.textColor = MyColors.white,
    this.fontSize = 16,
    this.borderRadius = 0,
    this.fontWeight = .w600,
    this.fontFamily = MyFonts.archivoNarrow,
    this.namedArgs,
    this.enable = true,
    this.prefix,
    this.suffix,
    required this.onTap,
  });

  final bool enable;
  final double? width;
  final double height, fontSize, borderRadius, borderWidth;
  final String text;
  final String? prefix, suffix;
  final Color textColor;
  final Color? borderColor;
  final FontWeight fontWeight;
  final String fontFamily;
  final Map<String, String>? namedArgs;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enable ? onTap : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: .circular(borderRadius),
          border: borderColor == null
              ? null
              : .all(color: borderColor!, width: borderWidth),
        ),
        alignment: .center,
        child: Row(
          spacing: 16,
          mainAxisAlignment: .center,
          children: [
            if (prefix != null) MyImageAssets(prefix!),
            Flexible(
              child: MyText(
                textAlign: .center,
                text: (namedArgs == null)
                    ? text.tr.toUpperCase()
                    : text.tr.trParams(namedArgs!).toUpperCase(),
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
                fontFamily: fontFamily,
                letterSpacing: fontSize * 0.12,
              ),
            ),
            if (suffix != null) MyImageAssets(suffix!),
          ],
        ),
      ),
    );
  }
}

class MyButtonIcon extends StatelessWidget {
  const MyButtonIcon(
    this.icon, {
    super.key,
    this.width,
    this.height = 56,
    this.borderColor,
    this.borderWidth = 0,
    this.borderRadius = 0,
    this.enable = true,
    required this.onTap,
    this.color = MyColors.white,
  });

  final bool enable;
  final double? width;
  final double height, borderRadius, borderWidth;
  final String icon;
  final Color color;
  final Color? borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enable ? onTap : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color.withValues(alpha: enable ? 1 : 0.5),
          borderRadius: .circular(borderRadius),
          border: borderColor == null
              ? null
              : .all(color: borderColor!, width: borderWidth),
        ),
        alignment: .center,
        child: MyImageAssets(icon),
      ),
    );
  }
}

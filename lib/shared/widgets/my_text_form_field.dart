import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/my_colors.dart';
import '../utils/my_fonts.dart';
import 'my_text.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    this.controller,
    this.borderRadius = 0,
    this.label,
    this.hintText,
    this.maxLines = 1,
    this.maxLength,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.labelFontSize = 14,
    this.labelFontWeight = .w500,
    this.textColor = MyColors.white,
    this.fontSize = 14,
    this.labelColor = MyColors.white2,
    this.isPassword = false,
    this.obscureText = true,
    this.required = false,
    this.icPassOnTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.textAlign = .start,
    this.autofocus = false,
    this.fontWeight = .w400,
    this.width,
    this.height = 56,
    this.fillColor,
    this.borderColor = MyColors.line,
    this.hintColor = MyColors.white2,
    this.padding = const .all(16),
  });

  final Color? fillColor;
  final Color borderColor, hintColor;
  final EdgeInsetsGeometry padding;
  final TextEditingController? controller;
  final int maxLines;
  final int? maxLength;
  final String? label, errorText, hintText;
  final double borderRadius, labelFontSize, fontSize, height;
  final double? width;
  final FontWeight labelFontWeight;
  final Color textColor, labelColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isPassword, obscureText, enabled, required, readOnly, autofocus;
  final VoidCallback? icPassOnTap;
  final ValueChanged<String>? onChanged, onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon, suffixIcon;
  final VoidCallback? onTap;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        if (label != null)
          RichText(
            text: TextSpan(
              children: [
                myTextSpan(
                  text: (label == null) ? "" : label!.tr,
                  color: labelColor,
                  fontSize: labelFontSize,
                  fontWeight: labelFontWeight,
                ),
                // myTextSpan(
                //   text: (required) ? " *" : "",
                //   color: MyColors.red,
                //   fontSize: labelFontSize,
                //   fontWeight: labelFontWeight,
                // ),
              ],
            ),
          ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: .center,
            // width: width,
            // height: height,
            decoration: BoxDecoration(
              color: fillColor,
              border: .all(color: borderColor),
            ),
            child: Padding(
              padding: padding,
              child: TextFormField(
                maxLines: maxLines,
                autofocus: autofocus,
                controller: controller,
                obscureText: isPassword && obscureText,
                enabled: enabled,
                readOnly: readOnly,
                textAlign: textAlign,
                style: TextStyle(
                  fontSize: fontSize,
                  fontFamily: MyFonts.archivo,
                  color: textColor,
                  fontWeight: fontWeight,
                ),
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                decoration: InputDecoration(
                  border: .none,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: fontSize,
                    fontFamily: MyFonts.archivo,
                    color: hintColor,
                    fontWeight: fontWeight,
                  ),
                  isDense: true,
                  contentPadding: .zero,
                  prefixIcon: prefixIcon,
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                  suffixIcon: suffixIcon,
                  suffixIconConstraints: BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                ),
                onChanged: onChanged,
                onFieldSubmitted: onFieldSubmitted,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyTextFormFieldNoBorder extends StatelessWidget {
  const MyTextFormFieldNoBorder({
    super.key,
    this.controller,
    this.textAlign = .center,
    this.textColor = MyColors.white,
    this.hintTextColor,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onFieldSubmitted,
    this.fontSize = 14,
    this.fontWeight = .w400,
    this.fontFamily = MyFonts.archivo,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final TextAlign textAlign;
  final Color textColor;
  final Color? hintTextColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged, onFieldSubmitted;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final String? hintText;
  final Widget? prefixIcon, suffixIcon;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      controller: controller,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: textColor,
        fontWeight: fontWeight,
      ),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        border: .none,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily,
          color: hintTextColor ?? MyColors.white2,
          fontWeight: fontWeight,
        ),
        isDense: true,
        contentPadding: .zero,
        prefixIcon: prefixIcon,
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: suffixIcon,
        suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
      ),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}

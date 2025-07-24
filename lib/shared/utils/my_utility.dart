import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/shared/utils/my_colors.dart';
import 'package:nocvla/shared/utils/my_fonts.dart';

import '../widgets/my_text.dart';

void showSnackbar({required String msg}) => Get.rawSnackbar(
  backgroundColor: MyColors.primary80,
  duration: const Duration(milliseconds: 2500),
  messageText: MyText(
    color: MyColors.secondary,
    text: msg,
    fontFamily: MyFonts.libreBaskerville,
  ),
);

void showErrSnackbar({required String msg}) => Get.rawSnackbar(
  backgroundColor: MyColors.red,
  duration: const Duration(milliseconds: 2500),
  messageText: MyText(
    color: MyColors.secondary,
    text: msg,
    fontFamily: MyFonts.libreBaskerville,
  ),
);

Color hexToColor({required String hex}) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF$hex';
  }
  return Color(int.parse('0x$hex'));
}

String twoDigits(int n) => n.toString().padLeft(2, '0');

String formatDuration(Duration d) {
  final days = twoDigits(d.inDays);
  final hours = twoDigits(d.inHours.remainder(24));
  final minutes = twoDigits(d.inMinutes.remainder(60));
  final seconds = twoDigits(d.inSeconds.remainder(60));
  return "$days:$hours:$minutes:$seconds";
}

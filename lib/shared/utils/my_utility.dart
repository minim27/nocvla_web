import 'package:flutter/material.dart';

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

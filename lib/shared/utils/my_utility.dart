import 'package:flutter/material.dart';

Color hexToColor({required String hex}) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF$hex';
  }
  return Color(int.parse('0x$hex'));
}

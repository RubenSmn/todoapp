import 'package:flutter/material.dart';

@immutable
class AppColors {
  final blue = createMaterialColor(Color(0xFF0D3B66));
  final yellow = createMaterialColor(Color(0xFFF4D35E));
  final sandy = createMaterialColor(Color(0xFFEE964B));
  final orange = createMaterialColor(Color(0xFFF95738));

  AppColors();
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF2E0EE1);
const Color scaffoldBackgroundColorLight = Color.fromARGB(255, 247, 247, 247);
const Color scaffoldBackgroundColor = Color.fromARGB(255, 24, 24, 24);
const Color appBarColor = Color(0xFF020064);
const Color cardColor = Color.fromARGB(255, 39, 39, 39);
const Color buttonColor = Color(0xFF3C2AE0);
const defaultColor = Colors.white;

Color isThemeMode(BuildContext context, {Color? dark, Color? light}) {
  Brightness currentBrightness = Theme.of(context).brightness;

  final cs = (currentBrightness == Brightness.dark)
      ? (dark ?? scaffoldBackgroundColor)
      : (light ?? scaffoldBackgroundColorLight);
  return cs;
}

const Color white = Colors.white;
const Color black = Colors.black;
const Color transparent = Colors.transparent;
const Color green = Colors.green;
const Color red = Colors.red;
const Color orange = Colors.orange;
const Color yellow = Colors.yellow;
const Color blue = Colors.blue;
const Color blueGrey = Colors.blueGrey;
const Color blueAccent = Colors.blueAccent;
const Color grey = Colors.grey;
final Color grey100 = Colors.grey.shade100;
final Color grey800 = Colors.grey.shade800;

const styleLight =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

MaterialStateProperty<Color?> createMaterialStateProperty(
  Color color, {
  MaterialState materialState = MaterialState.selected,
  int withAlpha = 128,
}) {
  late MaterialStateProperty<Color?> materialStateProperty;

  final ccc = color.withAlpha(withAlpha);

  switch (materialState) {
    case MaterialState.selected:
      materialStateProperty = MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected) ? ccc : null);

      break;
    case MaterialState.pressed:
      materialStateProperty = MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.pressed) ? ccc : null);

      break;
    case MaterialState.focused:
      materialStateProperty = MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected) ? ccc : null);

      break;
    default:
      materialStateProperty = MaterialStateProperty.resolveWith((states) =>
          (states.contains(MaterialState.selected) ||
                  states.contains(MaterialState.pressed))
              ? ccc
              : null);
  }

  return materialStateProperty;
}

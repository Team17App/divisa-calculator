// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../config/config.dart';

const TextStyle styles = TextStyle(fontSize: 15.0);
const TextStyle stylesMinH =
    TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold);
const TextStyle stylesMin12H =
    TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);
const TextStyle stylesMin12 =
    TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal);
const TextStyle stylesMin13H =
    TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold);
const TextStyle stylesMin13 =
    TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal);
const TextStyle stylesMin14H =
    TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);
const TextStyle stylesMin14 =
    TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal);
const TextStyle stylesMin = TextStyle(fontSize: 11.0);
const TextStyle stylesTitlesCard = TextStyle(fontWeight: FontWeight.bold);
const TextStyle stylesSubtitlesCard = TextStyle();
const TextStyle stylesTitles =
    TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
const TextStyle stylesTitles30 =
    TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold);

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

/// theme dark
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  primarySwatch: createMaterialColor(primaryColor),
  colorScheme: const ColorScheme.dark(primary: primaryColor),
  appBarTheme: const AppBarTheme(
    backgroundColor: appBarColor,
    elevation: 0,
  ),
  iconTheme: const IconThemeData(
    color: primaryColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: buttonColor,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: buttonColor,
    disabledColor: Colors.grey,
  ),
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(primaryColor),
    trackColor: createMaterialStateProperty(primaryColor),
    overlayColor: createMaterialStateProperty(primaryColor),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: createMaterialStateProperty(primaryColor),
    fillColor: createMaterialStateProperty(primaryColor),
  ),
  primaryIconTheme: const IconThemeData(
    color: white,
  ),
);

/// theme light
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  primarySwatch: createMaterialColor(primaryColor),
  colorScheme: const ColorScheme.light(primary: primaryColor),
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    elevation: 0,
  ),
  iconTheme: const IconThemeData(
    color: primaryColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: buttonColor,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: buttonColor,
    disabledColor: Colors.grey,
  ),
  scaffoldBackgroundColor: white,
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(primaryColor),
    trackColor: createMaterialStateProperty(primaryColor),
    overlayColor: createMaterialStateProperty(primaryColor),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: createMaterialStateProperty(primaryColor),
    fillColor: createMaterialStateProperty(primaryColor),
  ),
  primaryIconTheme: const IconThemeData(
    color: primaryColor,
  ),
);

/// decoraciones para tarjetas

BoxDecoration decorationCard({Color? color, double radius = 20.0}) =>
    BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color,
    );

const boxShadowCenter = BoxShadow(
  color: Colors.white,
  blurRadius: 60.0,
  spreadRadius: 5.0,
);

final decoCardTopLeft = BoxDecoration(
  borderRadius: BorderRadius.circular(20.0),
  gradient: LinearGradient(
    colors: [
      white,
      black.withOpacity(0.75),
      black,
    ],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  ),
);

final decoCardTopRight = BoxDecoration(
  borderRadius: BorderRadius.circular(20.0),
  gradient: LinearGradient(
    colors: [
      white,
      black.withOpacity(0.75),
      black,
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
);

final decoCardBottomLeft = BoxDecoration(
  borderRadius: BorderRadius.circular(20.0),
  gradient: LinearGradient(
    colors: [
      black,
      black.withOpacity(0.75),
      white,
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
);

final decoCardBottomRight = BoxDecoration(
  borderRadius: BorderRadius.circular(20.0),
  gradient: LinearGradient(
    colors: [
      black,
      black.withOpacity(0.75),
      white,
    ],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  ),
);

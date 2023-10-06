/* 
import 'package:flutter/material.dart';
import 'package:pokeapp/api-services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemaProvider extends GetxController {
  SharedPreferences? preferences;

  static const String shared_themeKey  = 'shared_themeKey';

  final styleLight = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 15,
      fontFamily: 'Sans');

  void temaClaro() {
    Get.changeTheme(
      ThemeData(
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
        primarySwatch: MaterialColor(0xFF6FD373, ColorsGnoosis.color),
        brightness: Brightness.light,
        canvasColor: Colors.black,
        primaryColor: ColorsGnoosis.primary_color_frooget,
        appBarTheme: AppBarTheme(
          color: ColorsGnoosis.primary_color_frooget.withOpacity(0.4),
        ),
        // ignore: deprecated_member_use
        accentColor: ColorsGnoosis.primary_color_frooget,
        iconTheme: IconThemeData(color: Colors.black),
        cardTheme: CardTheme(color: Colors.white),
        primaryIconTheme:
            IconThemeData(color: ColorsGnoosis.primary_color_frooget),
        textTheme: TextTheme(
          headline1: styleLight,
          headline2: styleLight,
          headline3: styleLight,
          headline4: styleLight,
          headline5: styleLight,
          headline6: styleLight,
          subtitle1: styleLight,
          subtitle2: styleLight,
          bodyText1: styleLight,
          bodyText2: styleLight,
          caption: styleLight,
        ),
      ),
    );
    preferences?.setBool(shared_themeKey, false);
  }

  /* void temaOscuro() {
    Get.changeTheme(ThemeData.dark());
    preferences?.setBool(prefkey, true);
  } */

  void temaPersonalizado() {
    Get.changeTheme(
      ThemeData(
        scaffoldBackgroundColor: Colors.black,
        backgroundColor: Colors.black,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
        ),
        primarySwatch: MaterialColor(0xFF6FD373, ColorsGnoosis.color),
        brightness: Brightness.dark,
        canvasColor: Colors.white,
        primaryColor: ColorsGnoosis.primary_color_frooget,
        appBarTheme: AppBarTheme(
          color: Colors.black,
        ),
        // ignore: deprecated_member_use
        accentColor: Color(0xFF6FD373),
        iconTheme: IconThemeData(color: Colors.white),
        cardTheme: CardTheme(color: Colors.black),
        primaryIconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          headline1: style,
          headline2: style,
          headline3: style,
          headline4: style,
          headline5: style,
          headline6: style,
          subtitle1: style,
          subtitle2: style,
          bodyText1: style,
          bodyText2: style,
          caption: style,
        ),
      ),
    );
  }

  @override
  void onInit() {
    cargarPreferencias().then((value) => cargarTema());

    super.onInit();
  }

  void cargarTema() {
    bool isDarkMode = preferences?.getBool(shared_themeKey) ?? true;

    // ignore: unnecessary_null_comparison
    if (isDarkMode == null) {
      preferences?.setBool(shared_themeKey, false);
      isDarkMode = false;
    }

    (isDarkMode) ? temaPersonalizado() : temaClaro();
  }

  Future<void> cargarPreferencias() async {
    preferences = await Get.putAsync<SharedPreferences>(
        () async => await SharedPreferences.getInstance());
  }
}
 */
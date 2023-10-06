// ignore: unused_import
import 'package:flutter/foundation.dart' as fundation;
import 'package:flutter/material.dart';

import 'utilities/utilities.dart';
import 'package:divisa_calculator/api-services/api_services.dart';
import 'package:divisa_calculator/config/config.dart';
import 'package:divisa_calculator/db/db_controller.dart';
import 'package:divisa_calculator/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(DbController());
  Get.put(AllController());
  //if (!fundation.kIsWeb) await PushNotificationsServices.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    // Context!
    initNotificationApi();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: APP_NAME,
      navigatorKey: navigatorKey,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: ScreenNames.main.route,
      routes: {
        ScreenNames.none.route: (context) => const SizedBox(),
        ScreenNames.onboarding.route: (context) => const SizedBox(),
        ScreenNames.main.route: (context) => const HomeMain(),
        ScreenNames.homeMain.route: (context) => const HomeMain(),
        ScreenNames.home.route: (context) => const HomePage(),
        ScreenNames.createProduct.route: (context) => const SizedBox(),
        ScreenNames.settings.route: (context) => const SizedBox(),
      },
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      translations: Languages(),
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }

  initNotificationApi() {
    /* if (!fundation.kIsWeb) {
      NotificationApi.init();

      PushNotificationsServices.messageStream.listen((message) {
        var notif = message.notification;
        var data = message.data;
        int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        debugPrint('MyApp: NUEVA NOTIFICACIÓN');

        NotificationApi.showNotification(
          id: id,
          title: notif?.title,
          body: notif?.body,
          payload: data['type'] ?? 'main.abs',
        );
      });

      NotificationApi.onNotifications.stream.listen((payload) {
        navigatorKey.currentState?.pushNamed('/');
      });
    } */
  }
}

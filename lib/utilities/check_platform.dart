import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class CheckPlatform {
  /// is Platform Web
  static bool get isModeWeb => kIsWeb;

  /// is Platform Mobile (IOS or Android)
  static bool get isModeMobile => Platform.isAndroid || Platform.isIOS;

  /// is Platform Desktop (Windows or Linux or MacOS)
  static bool get isModeDesktop =>
      Platform.isWindows || Platform.isLinux || Platform.isMacOS;

  /// is Platform is Android
  static bool get isAndroid => Platform.isAndroid;

  /// is Platform is IOS
  static bool get isIOS => Platform.isIOS;

  /// is Platform is Windows
  static bool get isWindows => Platform.isWindows;

  /// is Platform isLinux
  static bool get isLinux => Platform.isLinux;

  /// is Platform is MacOS
  static bool get isMacOS => Platform.isMacOS;

  /// is Platform is Fuchsia
  static bool get isFuchsia => Platform.isFuchsia;
}

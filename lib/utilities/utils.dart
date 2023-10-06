// ignore_for_file: constant_identifier_names, unused_field

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../config/config.dart';

enum FormatEngeener {
  f(1 / 1000000000000),
  n(1 / 1000000000),
  u(1 / 1000000),
  m(1 / 1000),
  _(1),
  K(1000),
  M(1000000),
  G(1000000000),
  T(1000000000000);

  static num calculate(num value, FormatEngeener fe) => value * fe.value;

  const FormatEngeener(this.value);
  final num value;
}

/// ToastGravity
/// Used to define the position of the Toast on the screen
enum Gravity {
  TOP,
  BOTTOM,
  CENTER,
  TOP_LEFT,
  TOP_RIGHT,
  BOTTOM_LEFT,
  BOTTOM_RIGHT,
  CENTER_LEFT,
  CENTER_RIGHT,
  SNACKBAR,
  NONE
}

class Utils {
/*   // get id device
  static Future<String?> deviceInfo() async {
    var deviceInfo = DeviceInfoPlugin();
    String? info;

    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      info = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      info = androidDeviceInfo.id; // unique ID on Android
    }
    return info;
  } */

  /// mensajes personales
  static Future<bool?> toast(String msg,
      {int toastLength = 0,
      Gravity gravity = Gravity.CENTER,
      int timeInSecForIosWeb = 1,
      Color backgroundColor = Colors.black54,
      Color textColor = Colors.white,
      double fontSize = 16.0}) async {
    final toastGravity = ToastGravity.values.elementAt(gravity.index);

    return await Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.values[toastLength],
      gravity: toastGravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  // convert String to mun
  static num convertToNum(String value) {
    String val = value.trim().isEmpty ? '0' : value.trim();
    num number = num.parse(val);
    return number;
  }

  /// custom date from epoch
  static String epochToCustomFormate(int epoch,
      [String formate = 'dd-MM-yyyy - h:mm a']) {
    final date = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    var format = DateFormat(formate);
    var dateResult = format.format(date);

    return dateResult;
  }

  static Future<DateTime?> showDate(BuildContext context,
      [DateTime? firstDate]) async {
    final dd = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      currentDate: DateTime.now(),
      firstDate: firstDate ?? DateTime(2023, 1, 1),
      lastDate: DateTime(2100, 12, 31),
    );
    return dd;
  }

  static Future<TimeOfDay?> showTime(BuildContext context,
      [TimeOfDay? initialTime]) async {
    final dd = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
    return dd;
  }

  static String numberFormat(double value) {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    return oCcy.format(value);
  }

  static String numberFormatCustom(double value,
      [String newPattern = "#,##0.00", String? locale]) {
    final oCcy = NumberFormat(newPattern, locale);
    return oCcy.format(value);
  }

/*   static Future<String?> scanPhoto() async {
    final value = await Get.toNamed(ScreenNames.qrScan.value);
    return value;
    // String photoScanResult = await scanner.scanPhoto();

    /* try {
      String? cameraScanResult = await scanner.scan();
      return cameraScanResult;
    } catch (_) {
      return null;
    } */
  } */

  static double auxDoubleParse(String value) {
    double resp = 0.0;
    try {
      resp = double.parse(value);
    } catch (e) {
      debugPrint('$e');
    }
    return resp;
  }

  static int auxIntParse(String value) {
    int resp = 0;
    try {
      resp = int.parse(value);
    } catch (_) {
      try {
        resp = int.parse(value.split('.').first);
      } catch (e) {
        debugPrint('$e');
      }
    }
    return resp;
  }

  static randomNumber([int max = 100]) {
    var rng = Random();
    final rrr = rng.nextInt(max);
    return rrr;
  }

/*   static Future<void> sendEmail({
    String subject = '',
    List<String> recipients = const [],
    List<String> cc = const [],
    List<String> bcc = const [],
    String body = '',
    List<String>? attachmentPaths,
    bool isHTML = false,
  }) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: recipients,
      cc: cc,
      bcc: bcc,
      attachmentPaths: attachmentPaths,
      isHTML: isHTML,
    );

    await FlutterEmailSender.send(email);
  } */

  static void clipboardData(String value,
      {String dialogMessage = 'Copiado al portapapeles',
      String errorMessage = 'Error',
      bool share = false,
      String? subject}) {
    if (value.isNotEmpty) {
      debugPrint("Copiado: $value");

      Clipboard.setData(ClipboardData(text: value));
      toast(dialogMessage);
    } else {
      Utils.toast(
        errorMessage,
        backgroundColor: red,
      );
    }
  }

  // formate time hh:mm:ss
  static String formatedTime({
    required int timeInSecond,
    bool showhours = false,
  }) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    int hh = (timeInSecond / 3600).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    String hour = hh.toString().length <= 1 ? "0$hh" : "$hh";

    if (showhours) return "$hour:$minute:$second";
    return "$minute:$second";
  }

  static List<int> formatedCustomTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    int hh = (timeInSecond / 3600).floor();
    int day = (timeInSecond / 86400).floor();

    return [sec, min, hh, day];
  }

  static Stream<int> countDownFrom(int n) async* {
    if (n > 0) {
      yield n;
      await Future.delayed(const Duration(seconds: 1));
      yield* countDownFrom(n - 1);
    } else {
      yield 0;
    }
  }
}

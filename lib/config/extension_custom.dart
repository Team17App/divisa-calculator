import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

/// Parse list integer to String with or without spaces, remove "[" and "]"
extension ParseListToString on List<int> {
  String listToString([bool removeSpaces = false]) {
    String value = '$this'.replaceAll("[", "").replaceAll("]", "");
    if (removeSpaces) value = value.replaceAll(" ", "");
    return value;
  }
}

/// Hexadecimal to Color and reverse
extension HexColors on Color {
  Color toColors(String code, [Color defaultColor = Colors.black]) {
    try {
      code = code.length <= 7 ? code.replaceAll("#", "#FF") : code;
      final color = Color(int.parse(code.substring(1), radix: 16) + 0x00000000);
      return color;
    } catch (_) {
      return defaultColor;
    }
  }

  String toHexA([String defaultColor = '#FF000000']) {
    try {
      return '#${value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
    } catch (_) {
      return defaultColor;
    }
  }
}

/// List method next or previous
extension ListExtensions on List {
  /// to next
  int toNext(int current, [bool keep = true]) {
    if ((current + 1) >= length) return keep ? 0 : current;

    return current++;
  }

  /// to previous
  int toPrevious(int current, [bool reverse = true]) {
    if ((current) < 0) return reverse ? length : current;

    return current--;
  }
}

/* extension FilteredWidget<T> on List<T> {
  /// [searchList] This function finds all the elements of a list type [T],
  /// using the parameterized function [by] and return `List<T>`
  List<T> searchList({required bool Function(T) by}) {
    List<T> items = [];
    return items.where(by).toList();
  }
} */

/// CAPITALICE String or Word
extension StringExtensions on String {
  /// capitalize string
  String toCapitalizes() {
    if (isEmpty) return '';
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  /// capitalize each word
  String toCapitalizeEachWord() {
    // ignore: unnecessary_this
    return this.split(' ').map((word) {
      if (word.isEmpty) {
        return '';
      }
      return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
    }).join(' ');
  }

  /// format pad left
  String setHide({int maxVisible = 2, String padding = '*', bool hide = true}) {
    String value = this;
    int width = value.length;

    if (hide) value = value.substring(width - maxVisible);

    final left = value.padLeft(width - maxVisible, padding);
    return left;
  }

  /// parse `String` to `int`.
  /// returns `-1` if it cannot parse the `string`
  int get toInteger {
    try {
      return int.parse(this);
    } catch (_) {
      return -1;
    }
  }

  /// parse `String` to `double`.
  /// returns `0.0` if it cannot parse the `string`
  double get toDouble {
    try {
      return double.parse(trim());
    } catch (_) {
      return 0.0;
    }
  }
}

/// [DateTime] on text format simple
extension DateTimeExtensions on DateTime {
  /// this Formate is `yyyy/MM/dd`
  String toFormate({String formate = 'dd/MM/yyyy', String locale = 'en'}) {
    var format = DateFormat(formate, locale);
    var dateResult = format.format(this);
    return dateResult;
  }

  /// get parse to yyyy-MM-dd format
  String get toYYYYMMdd {
    final y = year.toString().padLeft(4, '0');
    final M = month.toString().padLeft(2, '0');
    final d = day.toString().padLeft(2, '0');

    final value = "$y-$M-$d";
    return value;
  }

  /// Divide the value [DateTime] of the period by a thousand
  /// `millisecondsSinceEpoch`
  int get divideByThousand => millisecondsSinceEpoch ~/ 1000;
}

/// [int] on text any format
extension IntegerExtensions on int {
  /// format pad left
  String padValue({int width = 6, String padding = '0', bool isLeft = true}) {
    String value = '$this';
    final left = value.padLeft(width, padding);
    final right = value.padRight(width, padding);
    return isLeft ? left : right;
  }

  /// format pad left
  String setHide({int maxVisible = 2, String padding = '*', bool hide = true}) {
    String value = '$this';
    int width = value.length;

    if (hide) value = value.substring(width - maxVisible);

    final left = value.padLeft(width - maxVisible, padding);
    return left;
  }

  /// engineer format number
  String get toEngineerFormat {
    String value = toString();

    // ignore: no_leading_underscores_for_local_identifiers
    int _pows(int exponent) {
      return math.pow(10, exponent).toInt();
    }

    const int digits = 1;
    final _ = _pows(0);
    final K = _pows(3);
    final M = _pows(6);
    final G = _pows(9);
    final T = _pows(12);
    final P = _pows(15);
    final E = _pows(18);

    // if (this < 1) return '${this * 1000}m';

    if (this >= _ && this < K) return value;

    if (this >= K && this < M) return '${(this / K).toStringAsFixed(digits)}k';

    if (this >= M && this < G) return '${(this / M).toStringAsFixed(digits)}M';

    if (this >= G && this < T) return '${(this / G).toStringAsFixed(digits)}G';

    if (this >= T && this < P) return '${(this / T).toStringAsFixed(digits)}T';

    if (this >= P && this < E) return '${(this / P).toStringAsFixed(digits)}P';

    if (this >= E) return '${(this / P).toStringAsFixed(digits)}E';

    return value;
  }

  /// [isNotZero] is this `Integer` is not zero
  bool get isNotZero => this != 0;
}

/* /// [double] on text format simple
extension DoubleExtensions on double {
  /// cast String to double validate
  String toFormate({String formate = 'zzz', String locale = 'en'}) {
    return 'dateResult';
  }
} */

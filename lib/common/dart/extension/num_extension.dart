import 'dart:math' as Math;

import 'package:easy_localization/easy_localization.dart';

final decimalFormat = NumberFormat.decimalPattern("en");

extension NumExt on num {
  static num? safeParse(String? source) {
    if (source == null) return null;
    return num.tryParse(source);
  }

  String toComma() {
    return decimalFormat.format(this);
  }

  bool get isOdd => this % 2 != 0;

  bool get isEven => this % 2 == 0;

  bool isBetween(num min, num max) => this >= min && this <= max;

  num toPrecision(int fractionDigits) {
    final factor = Math.pow(10, fractionDigits);
    return (this * factor).round() / factor;
  }

  num clampTo(num min, num max) => this.clamp(min, max);

  String get withPlusMinus {
    if (this > 0) {
      return "+$this";
    } else if (this < 0) {
      return "$this";
    } else {
      return "0";
    }
  }
}

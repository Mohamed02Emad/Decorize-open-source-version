import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension DateTimeExtensions on DateTime? {
  DateTime get validate {
    if (this == null) {
      return DateTime.now();
    }
    return this!.toLocal();
  }

  String format({String format = 'dd/MM/yyyy'}) {
    return DateFormat(format, 'en').format(validate);
  }

  String formatTime({String format = 'hh:mm a'}) {
    return DateFormat(format, 'en').format(validate);
  }

  bool get isNull => this == null;

  DateTime get startOfDay => DateTime(validate.year, validate.month, validate.day, 0, 0, 0, 0);

  DateTime get endOfDay => DateTime(validate.year, validate.month, validate.day, 23, 59, 59, 999);

  String get time12h => validate.formatTime(format: 'hh:mm a');

  String get time24 => validate.formatTime(format: 'HH:mm');

  String get dateDdMmYyyy => validate.format(format: 'dd-MM-yyyy');

  String get dateYyyyMmDd => validate.format(format: 'yyyy-MM-dd');

  String get dateDdMmYyyyHhMm => validate.format(format: 'dd-MM-yyyy hh:mm a');

  String get dateYyyyMmDdHhMmSs => validate.format(format: 'yyyy-MM-dd hh:mm:ss');

  String get utcTime12h => validate.toUtc().formatTime(format: 'hh:mm a');

  String get utcTime24 => validate.toUtc().formatTime(format: 'HH:mm');

  String get utcDateDdMmYyyy => validate.toUtc().format(format: 'dd-MM-yyyy');

  String get utcDateYyyyMmDd => validate.toUtc().format(format: 'yyyy-MM-dd');

  String get utcDateDdMmYyyyHhMm => validate.toUtc().format(format: 'dd-MM-yyyy hh:mm a');

  String get utcDateYyyyMmDdHhMmSs => validate.toUtc().format(format: 'yyyy-MM-dd hh:mm:ss');

  static DateTime? fromTime12h(String? time12h) {
    if (time12h == null) return null;
    try {
      final parsedTime = DateFormat('hh:mm a', 'en').parse(time12h);
      return DateTime(2012, 1, 1, parsedTime.hour, parsedTime.minute);
    } catch (e) {
      throw FormatException('Invalid 12-hour time format: $time12h');
    }
  }

  static DateTime? fromTime24(String? time24) {
    if (time24 == null || time24.trim().isEmpty) {
      throw FormatException('Time string cannot be null or empty');
    }
    try {
      final parsedTime = DateFormat('HH:mm', 'en').parseStrict(time24);
      return DateTime(2012, 1, 1, parsedTime.hour, parsedTime.minute);
    } catch (e) {
      throw FormatException('Invalid 24-hour time format: $time24');
    }
  }

  String get formatDateName {
    final locale = Intl.getCurrentLocale();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = validate;

    final target = DateTime(targetDate.year, targetDate.month, targetDate.day);
    final diffDays = target.difference(today).inDays;

    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    if (diffDays == 0) {
      return LocaleKeys.common_time_today.tr();
    } else if (diffDays == 1) {
      return LocaleKeys.common_time_tomorrow.tr();
    } else if (target.isAfter(startOfWeek) && target.isBefore(endOfWeek.add(const Duration(days: 1)))) {
      return DateFormat.EEEE(locale).format(target);
    } else {
      return DateFormat.yMMMMd(locale).format(target);
    }
  }

  String get getTimeDifferenceFromNow {
    final now = DateTime.now();
    print("validate $validate");
    print("validate now $now");
    final difference = now.difference(validate.toLocal());

    if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      return '$years${LocaleKeys.common_time_y.tr()}';
    } else if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return '$months${LocaleKeys.common_time_month.tr()}';
    } else if (difference.inDays >= 1) {
      final days = difference.inDays;
      return '$days${LocaleKeys.common_time_d.tr()}';
    } else if (difference.inMinutes < 1) {
      return LocaleKeys.common_time_now.tr();
    } else {
      final hours = difference.inHours;
      final minutes = difference.inMinutes.remainder(60);
      return '$hours${LocaleKeys.common_time_h.tr()}$minutes${LocaleKeys.common_time_m.tr()}';
    }
  }

  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: validate.hour, minute: validate.minute);
  }
}

extension TimeOfDayExtensions on TimeOfDay? {
  TimeOfDay get validate {
    if (this == null) {
      return TimeOfDay.now();
    }
    return this!;
  }

  DateTime toDateTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, validate.hour, validate.minute);
  }

  String formatTime({String format = 'hh:mm a'}) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, validate.hour, validate.minute);
    return dateTime.formatTime(format: format);
  }

  bool isAfter(TimeOfDay time) {
    return validate.hour > time.hour || (validate.hour == time.hour && validate.minute > time.minute);
  }
}

extension DurationEx on Duration? {
  Duration get validate {
    if (this == null) {
      return const Duration();
    }
    return this!;
  }

  String formatDuration({String format = 'hh:mm:ss'}) {
    final padded = NumberFormat("00");

    final h = validate.inHours;
    final m = validate.inMinutes.remainder(60);
    final s = validate.inSeconds.remainder(60);

    return format
        .replaceAllMapped(RegExp(r'hh'), (_) => padded.format(h))
        .replaceAllMapped(RegExp(r'h(?!h)'), (_) => h.toString())
        .replaceAllMapped(RegExp(r'mm'), (_) => padded.format(m))
        .replaceAllMapped(RegExp(r'm(?!m)'), (_) => m.toString())
        .replaceAllMapped(RegExp(r'ss'), (_) => padded.format(s))
        .replaceAllMapped(RegExp(r's(?!s)'), (_) => s.toString());
  }
}

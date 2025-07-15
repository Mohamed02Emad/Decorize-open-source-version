import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';

extension StringExtention on String {
  String ellipsize({length = 8}) {
    if (this.length <= length) {
      return this;
    }
    return '${substring(0, 7).trim()} ...';
  }

  String capitalizeFirst() {
    final String first = firstLetterUpperCase();
    final newString = replaceFirst(first.toLowerCase(), first);
    return newString;
  }

  String get currency {
    return this + tr(LocaleKeys.Currency_egp);
  }

  String get enterHint => '${LocaleKeys.common_enter.tr()} $this';

  String firstLetterUpperCase() {
    if (this.isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  int toInt() {
    return int.tryParse(this) ?? 0;
  }

  double toDouble() {
    return double.tryParse(this) ?? 0.0;
  }
}

extension NullableStringExtension on String? {
  bool get isEmptyOrNull => this == null || this!.isEmpty;
}

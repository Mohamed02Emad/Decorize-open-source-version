import 'package:decorizer/common/data/preference/item/nullable_preference_item.dart';
import 'package:decorizer/common/theme/custom_theme.dart';

class Prefs {
  static final appTheme = NullablePreferenceItem<CustomTheme>('appTheme');
}

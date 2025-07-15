import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

enum StaticPageType {
  aboutUs,
  terms,
  policy;

  String get displayName {
    switch (this) {
      case StaticPageType.aboutUs:
        return LocaleKeys.more_about_us.tr();
      case StaticPageType.terms:
        return LocaleKeys.more_terms_and_conditions.tr();
      case StaticPageType.policy:
        return LocaleKeys.more_privacy_policy.tr();
    }
  }

  String get apiName {
    switch (this) {
      case StaticPageType.aboutUs:
        return 'about-us';
      case StaticPageType.terms:
        return 'terms';
      case StaticPageType.policy:
        return 'privacy';
    }
  }
}

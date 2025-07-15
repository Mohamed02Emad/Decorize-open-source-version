import 'package:decorizer/common/constant/app_svgs.dart';

enum LanguageEnum {
  ar,
  fr,
  en;

  static LanguageEnum fromString(String language) {
    switch (language.toLowerCase()) {
      case 'ar':
      case 'arabic':
      case 'العربية':
        return LanguageEnum.ar;
      case 'fr':
      case 'french':
        return LanguageEnum.fr;
      default:
        return LanguageEnum.en;
    }
  }
}

extension LanguageEnumExtension on LanguageEnum {
  String get displayName {
    switch (this) {
      case LanguageEnum.ar:
        return "العربية";
      case LanguageEnum.fr:
        return "French";
      case LanguageEnum.en:
        return "English";
    }
  }

  String get flagPath {
    switch (this) {
      case LanguageEnum.ar:
        return AppSvgs.egypt;
      case LanguageEnum.fr:
        return AppSvgs.france;
      case LanguageEnum.en:
        return AppSvgs.usa;
    }
  }

  bool get isRtl {
    return this == LanguageEnum.ar;
  }
}

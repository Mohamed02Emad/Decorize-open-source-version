import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';

import '../resources/gen/locale_keys.g.dart';

class Validator {
  static String? phone(String? phone) {
    if (phone.isEmptyOrNull) return 'empty_phone'.tr();

    final RegExp egyptionPhoneNumberRegex = RegExp(r'^01[0-9]{9}$');

    if (!egyptionPhoneNumberRegex.hasMatch(phone!)) {
      return 'invalid_phone_number'.tr();
    }

    return null;
  }
  static String? nationalId(String? value) {
    if (value.isEmptyOrNull) {
      return LocaleKeys.validation_empty_national_id.tr();
    }

    final RegExp nationalIdRegex = RegExp(r'^\d{14}$');
    if (!nationalIdRegex.hasMatch(value!)) {
      return LocaleKeys.validation_invalid_national_id.tr();
    }

    return null;
  }
  static String? servicePrice(String? value) {
    if (value.isEmptyOrNull) {
      return LocaleKeys.validation_empty_price.tr();
    }
    if (double.tryParse(value!) == null || double.parse(value) <= 0) {
      return LocaleKeys.validation_invalid_service_price.tr();
    }
    return null;
  }
  static String? estimatedDuration(String? value) {
    if (value.isEmptyOrNull) {
      return LocaleKeys.validation_empty_duration.tr();
    }
    if (int.tryParse(value!) == null || int.parse(value) <= 0) {
      return LocaleKeys.validation_invalid_duration.tr();
    }
    return null;
  }
  static String? comment(String? value) {
    if (value.isEmptyOrNull) {
      return LocaleKeys.validation_empty_comment.tr();
    }
    return null;
  }

  static String? email(String? email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+(?:\.[a-zA-Z]+)?$');
    if (email.isEmptyOrNull) {
      return LocaleKeys.validation_empty_email.tr();
    } else if (!emailRegex.hasMatch(email!)) {
      return LocaleKeys.validation_invalid_email_format.tr();
    }
    return null;
  }

  static String? confirmPassword(String? value, String text) {
    if (value != text) return LocaleKeys.validation_not_valid.tr();
    return null;
  }

  static password(String? value) {
    if (value.isEmptyOrNull) {
      return LocaleKeys.validation_empty_password.tr();
    } else if (value!.length < 8) {
      return LocaleKeys.validation_password_must_be_at_least.tr();
    }
    return null;
  }

  static String? name(String? value) {
    if (value.isEmptyOrNull) return LocaleKeys.validation_empty_name.tr();
    return null;
  }

  static String? emptyField(String? value) {
    if (value.isEmptyOrNull) return LocaleKeys.error_error_happened.tr();
    return null;
  }
}

import 'package:decorizer/common/extentions/context_extension.dart';
import 'package:decorizer/common/language/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/app.dart';

class TextStyles {
  const TextStyles._();
  static const String fontFamily = 'IBM';
  static const String arabicFontFamily = 'IBM';

  // Bold TextStyles
  static TextStyle bold22({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 22.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle bold21({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 21.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle bold20({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 20.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle bold19({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 19.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle bold18({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 18.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle bold17({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 17.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle bold16({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 16.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle bold15({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 15.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle bold14({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 14.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle bold13({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 13.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle bold12({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 12.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  // SemiBold TextStyles
//********************************************************************************************//
  static TextStyle bold24Weight700({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 24.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );
  static TextStyle bold18Weight700({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 18.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );
  static TextStyle bold16Weight700({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 16.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle semiBold32({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 32.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle regular16Weight400({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 16.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );
  static TextStyle regular12Weight400({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 12.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle regular12Weight400WithUnderLine(
          {BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 12.sp,
        color: color ?? (context ?? appContext!).appColors.text,
        decorationColor: color ?? (context ?? appContext!).appColors.text,
        decoration: TextDecoration.underline,
      );
  static TextStyle regular14Weight400({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 14.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );
  //*****************************************************************************************//

  static TextStyle semiBold22({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 22.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle semiBold21({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 21.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle semiBold20({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 20.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle semiBold19({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 19.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle semiBold18({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 18.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle semiBold17({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 17.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle semiBold16({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 16.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle semiBold15({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 15.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle semiBold14({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 14.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle semiBold13({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 13.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle semiBold12({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 12.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  // Regular TextStyles
  static TextStyle regular22({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 22.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle regular21({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 21.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle regular20({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 20.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle regular19({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 19.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle regular18({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 18.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle regular17({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 17.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle regular16({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 16.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle regular15({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 15.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle regular14({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 14.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle regular13({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 13.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle regular12({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 12.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle regular11({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 11.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle regular10({BuildContext? context, Color? color}) =>
      TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 10.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  // Medium TextStyles
  static TextStyle medium22({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 22.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle medium21({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 21.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle medium20({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 20.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle medium19({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 19.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle medium18({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 18.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle medium17({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 17.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle medium16({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 16.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle medium15({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 15.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle medium14({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 14.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle medium13({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 13.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  static TextStyle medium12({BuildContext? context, Color? color}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: isArabic() ? arabicFontFamily : fontFamily,
        fontSize: 12.sp,
        color: color ?? (context ?? appContext!).appColors.text,
      );

  // Helper Method to Get Font Family
  static String getFontFamily() => isArabic() ? arabicFontFamily : fontFamily;
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


extension TextStyleEx on TextStyle {
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);

  TextStyle get s8 => copyWith(fontSize: 8.sp);
  TextStyle get s9 => copyWith(fontSize: 9.sp);
  TextStyle get s10 => copyWith(fontSize: 10.sp);
  TextStyle get s11 => copyWith(fontSize: 11.sp);
  TextStyle get s12 => copyWith(fontSize: 12.sp);
  TextStyle get s13 => copyWith(fontSize: 13.sp);
  TextStyle get s14 => copyWith(fontSize: 14.sp);
  TextStyle get s15 => copyWith(fontSize: 15.sp);
  TextStyle get s16 => copyWith(fontSize: 16.sp);
  TextStyle get s18 => copyWith(fontSize: 18.sp);
  TextStyle get s20 => copyWith(fontSize: 20.sp);
  TextStyle get s22 => copyWith(fontSize: 22.sp);
  TextStyle get s24 => copyWith(fontSize: 24.sp);
  TextStyle get s28 => copyWith(fontSize: 28.sp);
  TextStyle get s32 => copyWith(fontSize: 32.sp);


  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);
  TextStyle get overline => copyWith(decoration: TextDecoration.overline);

  TextStyle get ellipsis => copyWith(overflow: TextOverflow.ellipsis);

  TextStyle setColor(Color color) => copyWith(color: color);
  TextStyle setFontSize(double size) => copyWith(fontSize: size);
  TextStyle setFontWeight(FontWeight weight) => copyWith(fontWeight: weight);

  TextStyle setHeight(double value) => copyWith(height: value);
  TextStyle setLetterSpacing(double value) => copyWith(letterSpacing: value);
  TextStyle setFontStyle(FontStyle style) => copyWith(fontStyle: style);
  TextStyle setDecoration(TextDecoration decoration) => copyWith(decoration: decoration);
  TextStyle setDecorationColor(Color color) => copyWith(decorationColor: color);
  TextStyle setDecorationStyle(TextDecorationStyle style) => copyWith(decorationStyle: style);
  TextStyle setWordSpacing(double value) => copyWith(wordSpacing: value);
  TextStyle setShadows(List<Shadow> shadows) => copyWith(shadows: shadows);
  TextStyle setForeground(Color color) => copyWith(foreground: Paint()..color = color);
  TextStyle setBackground(Color color) => copyWith(background: Paint()..color = color);
  TextStyle setFontFamily(String? family) => copyWith(fontFamily: family);
  TextStyle setPackage(String? package) => copyWith(package: package);
  TextStyle setHeightPercent(double value) => copyWith(height: value);
}
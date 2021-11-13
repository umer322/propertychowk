import 'package:flutter/material.dart';
import 'colors.dart';



class Times{
  static const Duration fastest = const Duration(milliseconds: 150);
  static const fast = const Duration(milliseconds: 250);
  static const medium = const Duration(milliseconds: 350);
  static const slow = const Duration(milliseconds: 700);
  static const slower = const Duration(milliseconds: 1000);
}




TextStyle defaultHintStyle=TextStyle(color: Colors.grey);

TextStyle defaultLabelStyle=TextStyle(color: primaryColor,fontSize: FontSizes.s20,fontWeight: FontWeight.w600);
class FontSizes {
  /// Provides the ability to nudge the app-wide font scale in either direction
  static double get scale => 1;
  static double get s6 => (6 * scale);
  static double get s8 => (8 * scale);
  static double get s10 => (10 * scale);
  static double get s11 => (11 * scale);
  static double get s12 => (12 * scale);
  static double get s14 => (14 * scale);
  static double get s16 => (16 * scale);
  static double get s18 => (18 * scale);
  static double get s20 => (20 * scale);
  static double get s24 => (24 * scale);
  static double get s30 => (30 * scale);
  static double get s36 => (36 * scale);
  static double get s40 => (40 * scale);
  static double get s44 => (44 * scale);
  static double get s48 => (48 * scale);
}



class TextStyles {
  /// Declare a base style for each Family


  static const TextStyle defaultTextStyle = TextStyle(fontWeight: FontWeight.w400, height: 1);

  static TextStyle get h1 =>
      defaultTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: FontSizes.s30, letterSpacing: 1, height: 1.17);
  static TextStyle get h2 => h1.copyWith(fontSize: FontSizes.s24, letterSpacing: -.5, height: 1.16);
  static TextStyle get h3 => h1.copyWith(fontSize: FontSizes.s18, letterSpacing: -.05, height: 1.29);
  static TextStyle get h4 => h1.copyWith(fontSize: FontSizes.s20, letterSpacing: -.05, height: 1.29);
  static TextStyle get title1 => defaultTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: FontSizes.s16, height: 1.31);
  static TextStyle get title2 => title1.copyWith(fontWeight: FontWeight.w500, fontSize: FontSizes.s14, height: 1.36);
  static TextStyle get body1 => defaultTextStyle.copyWith(fontWeight: FontWeight.normal, fontSize: FontSizes.s14, height: 1.71);
  static TextStyle get body2 => body1.copyWith(fontSize: FontSizes.s12, height: 1.5, letterSpacing: .2);
  static TextStyle get body3 => body1.copyWith(fontSize: FontSizes.s12, height: 1.5, fontWeight: FontWeight.bold);
  static TextStyle get callout1 =>
      defaultTextStyle.copyWith(fontWeight: FontWeight.w800, fontSize: FontSizes.s12, height: 1.17, letterSpacing: .5);
  static TextStyle get callout2 => callout1.copyWith(fontSize: FontSizes.s10, height: 1, letterSpacing: .25);
  static TextStyle get caption => defaultTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: FontSizes.s11, height: 1.36);
}
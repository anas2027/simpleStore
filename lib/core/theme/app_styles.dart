import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  const AppStyles._();

  // Material 3-inspired text scale with universal readable steps.
  static TextStyle get xSmall => TextStyle(
    fontSize: 11.sp,
    height: 16 / 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
  );

  static TextStyle get small => TextStyle(
    fontSize: 12.sp,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
  );

  static TextStyle get medium => TextStyle(
    fontSize: 14.sp,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
  );

  static TextStyle get large =>
      TextStyle(fontSize: 16.sp, height: 24 / 16, fontWeight: FontWeight.w500);

  static TextStyle get xLarge =>
      TextStyle(fontSize: 22.sp, height: 28 / 22, fontWeight: FontWeight.w600);

  static TextTheme textTheme(TextTheme base) {
    return base.copyWith(
      labelSmall: xSmall,
      bodySmall: small,
      bodyMedium: medium,
      titleMedium: large,
      titleLarge: xLarge,
      headlineSmall: xLarge,
    );
  }
}

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  const AppSizes._();

  // Material 3 uses a 4dp baseline grid.
  static double get xxs => 4.w;
  static double get xs => 8.w;
  static double get sm => 12.w;
  static double get md => 16.w;
  static double get lg => 20.w;
  static double get xl => 24.w;
  static double get xxl => 32.w;

  static double get radiusSm => 8.r;
  static double get radiusMd => 12.r;
  static double get radiusLg => 16.r;

  static double get iconSm => 16.r;
  static double get iconMd => 20.r;
  static double get imageCard => 92.w;
  static double get imageLarge => 220.w;
}

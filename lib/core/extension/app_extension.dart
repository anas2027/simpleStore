import 'package:easy_localization/easy_localization.dart';

extension AppLocaleExtension on String {
  String get locale => this.tr();
}

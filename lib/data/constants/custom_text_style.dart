import 'package:bank_test_app/data/constants/custom_colors.dart';
import 'package:flutter/widgets.dart';

class CustomStyles {
  static TextStyle get headline1 =>
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  static TextStyle get bodyText1 =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

  static TextStyle get caption =>
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w300);

  static TextStyle get buttonBlackText =>
      bodyText1.copyWith(color: AppColors.black);

  static TextStyle get errorText => const TextStyle(
    fontSize: 12,
    color: AppColors.red,
    fontWeight: FontWeight.bold,
  );

  static BoxDecoration get whiteBoxDecoration => BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(10),
  );
}

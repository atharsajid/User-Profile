import 'package:flutter/material.dart';

class Spacing {
  static const SizedBox vSmall = SizedBox(height: 4);
  static const SizedBox vStandard = SizedBox(height: 8);
  static const SizedBox vMedium = SizedBox(height: 16);
  static const SizedBox vLarge = SizedBox(height: 24);
  static const SizedBox vExtraLarge = SizedBox(height: 32);
  static const SizedBox vXXLarge = SizedBox(height: 48);

  static const SizedBox hSmall = SizedBox(width: 4);
  static const SizedBox hStandard = SizedBox(width: 8);
  static const SizedBox hMedium = SizedBox(width: 16);
  static const SizedBox hLarge = SizedBox(width: 24);
  static const SizedBox hExtraLarge = SizedBox(width: 32);
  static const SizedBox hXXLarge = SizedBox(width: 48);

  static const SizedBox fullWidth = SizedBox(width: double.infinity);
  static const SizedBox fullHeight = SizedBox(height: double.infinity);

  static SizedBox vSize(double size) => SizedBox(height: size);
  static SizedBox hSize(double size) => SizedBox(width: size);
}

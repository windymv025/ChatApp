import 'package:flutter/material.dart';

import 'colors.dart';
import 'font_family.dart';

final ThemeData themeData = ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.light,
  primarySwatch: MaterialColor(AppColors.orange[500]!.value, AppColors.orange),
  primaryColor: AppColors.orange[500],
  primaryColorBrightness: Brightness.light,
);

final ThemeData themeDataDark = ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  primaryColor: AppColors.orange[500],
  primaryColorBrightness: Brightness.dark,
);

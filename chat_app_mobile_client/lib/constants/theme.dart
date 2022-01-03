import 'package:flutter/material.dart';

import 'colors.dart';
import 'font_family.dart';
import 'styles.dart';

//light theme
final ThemeData themeDataLight = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: inputDecorationTheme(),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: appBarTheme(),
  fontFamily: FontFamily.productSans,
  brightness: Brightness.light,
  primaryColor: kPrimaryColor,
  primaryColorBrightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: kMainBlueColor,
    onPrimary: kPrimaryColor,
    secondary: Colors.black54,
    brightness: Brightness.light,
  ),
);

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: pageNameStyle,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineEnabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: kMainBlueColor),
    gapPadding: 5,
  );
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: kMainBlueColor),
    gapPadding: 5,
  );
  OutlineInputBorder errorOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Colors.red),
    gapPadding: 5,
  );
  OutlineInputBorder disabledOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Colors.grey),
    gapPadding: 5,
  );
  return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      enabledBorder: outlineEnabledBorder,
      errorBorder: errorOutlineInputBorder,
      disabledBorder: disabledOutlineInputBorder,
      focusedErrorBorder: errorOutlineInputBorder,
      focusedBorder: outlineInputBorder,
      focusColor: kMainBlueColor);
}

//dark theme
final ThemeData themeDataDark = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black87,
  inputDecorationTheme: inputDecorationDarkTheme(),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: appBarDarkTheme(),
  fontFamily: FontFamily.productSans,
  primaryColor: kPrimaryColor,
  primaryColorBrightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: kMainBlueColor,
    onPrimary: kPrimaryColor,
    secondary: kLightColor,
    brightness: Brightness.dark,
  ),
);

InputDecorationTheme inputDecorationDarkTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: kMainBlueColor),
    gapPadding: 5,
  );
  OutlineInputBorder outlineEnabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Colors.white),
    gapPadding: 5,
  );
  OutlineInputBorder errorOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Colors.red),
    gapPadding: 5,
  );
  OutlineInputBorder disabledOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Colors.grey),
    gapPadding: 5,
  );
  return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      enabledBorder: outlineEnabledBorder,
      errorBorder: errorOutlineInputBorder,
      disabledBorder: disabledOutlineInputBorder,
      focusedErrorBorder: errorOutlineInputBorder,
      focusedBorder: outlineInputBorder,
      focusColor: kMainBlueColor);
}

AppBarTheme appBarDarkTheme() {
  return const AppBarTheme(
    color: Colors.black87,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: pageNameStyle,
  );
}

TextTheme textThemeDark() {
  return const TextTheme(
      headline1: pageNameStyle,
      headline2: titleStyle,
      headline3: titleBlueStyle,
      headline4: titleStyleWhite,
      headline5: tileCountDownStyle,
      subtitle1: subTileCountDownStyle,
      bodyText1: titleStyle);
}

import 'package:flutter/material.dart';
import 'package:rechap/ui/core/themes/app_palette.dart';
import 'package:rechap/ui/core/themes/app_dimens.dart';

ThemeData get lightTheme => ThemeData(
  fontFamily: 'ProductSans',
  useMaterial3: true,
  textTheme: TextTheme(
    bodySmall: TextStyle(
      color: AppPallete.black,
      fontSize: kFontSize16,
      fontWeight: FontWeight.w300,
    ),
    bodyMedium: TextStyle(
      color: AppPallete.black,
      fontSize: kFontSize20,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: AppPallete.black,
      fontSize: kFontSize24,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      color: AppPallete.black,
      fontSize: kFontSize24,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: TextStyle(
      color: AppPallete.black,
      fontSize: kFontSize20,
      fontWeight: FontWeight.w500, // Text style for appbar title
    ),
  ),
  colorScheme: ColorScheme.light(
    onSurface: AppPallete.black, // Text color title, etc
    onSurfaceVariant: AppPallete.greyText, // Text color subtitle, etc
    onPrimaryContainer: AppPallete.blackPrimary, // Button background color
    onSecondaryContainer: AppPallete.white, // Button text color
    surface: AppPallete.white, // Background color v1
    onSecondaryFixed: AppPallete.backgroundGrey,
    outlineVariant: AppPallete.greyBorder, // Border color
  ),
  appBarTheme: AppBarThemeData(backgroundColor: AppPallete.white),
);

ThemeData get darkTheme => ThemeData(
  fontFamily: 'ProductSans',
  useMaterial3: true,
  textTheme: TextTheme(
    bodySmall: TextStyle(color: AppPallete.white, fontSize: kFontSize16),
    bodyMedium: TextStyle(color: AppPallete.white, fontSize: kFontSize20),
    titleMedium: TextStyle(color: AppPallete.white, fontSize: kFontSize24),
    headlineSmall: TextStyle(
      color: AppPallete.white,
      fontSize: kFontSize20,
      fontWeight: FontWeight.w400,
    ),
  ),
  colorScheme: ColorScheme.dark(
    onSurface: AppPallete.white, // Text color title, etc
    onSurfaceVariant: AppPallete.white, // Text color subtitle, etc
    onPrimaryContainer: AppPallete.yellowSecondary, // Button background color
    onSecondaryContainer: AppPallete.blackPrimary, // Button text color
    surface: AppPallete.black,
    outlineVariant: AppPallete.black,
    onSecondaryFixed: AppPallete.black,
  ),
  appBarTheme: AppBarThemeData(backgroundColor: AppPallete.black),
);

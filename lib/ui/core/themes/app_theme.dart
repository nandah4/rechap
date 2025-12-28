import 'package:flutter/material.dart';
import 'package:rechap/ui/core/themes/app_palette.dart';

ThemeData get lightTheme => ThemeData(
  fontFamily: 'ProductSans',
  useMaterial3: true,
  textTheme: TextTheme(
    bodySmall: TextStyle(color: AppPallete.black, fontSize: 14),
    bodyMedium: TextStyle(color: AppPallete.black, fontSize: 16),
    titleMedium: TextStyle(color: AppPallete.black, fontSize: 18),
  ),
  colorScheme: ColorScheme.light(
    onSurface: AppPallete.black,
    onSurfaceVariant: AppPallete.greyText,
  ),
  appBarTheme: AppBarThemeData(backgroundColor: AppPallete.white),
);

ThemeData get darkTheme => ThemeData(
  fontFamily: 'ProductSans',
  useMaterial3: true,
  textTheme: TextTheme(
    bodySmall: TextStyle(color: AppPallete.white, fontSize: 14),
    bodyMedium: TextStyle(color: AppPallete.white, fontSize: 16),
    titleMedium: TextStyle(color: AppPallete.white, fontSize: 18),
  ),
  colorScheme: ColorScheme.dark(
    onSurface: AppPallete.white,
    onSurfaceVariant: AppPallete.white,
  ),
  appBarTheme: AppBarThemeData(backgroundColor: AppPallete.black),
);

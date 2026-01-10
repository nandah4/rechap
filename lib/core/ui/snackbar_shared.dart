import 'package:flutter/material.dart';

// Internal Package
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/core/themes/app_typography.dart';

// Eksternal Package

class SnackbarShared {
  static void show(
    BuildContext context, {
    required String message,
    Color bgColor = AppPallete.white,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: bgColor,
          duration: duration,
          content: Padding(
            padding: .symmetric(horizontal: kSpacing16),
            child: Text(
              message,
              style: kDescriptionSnackbarNotification(context),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
  }

  static void success(BuildContext context, String message, int duration) {
    show(
      context,
      message: message,
      bgColor: AppPallete.success,
      duration: Duration(seconds: duration),
    );
  }

  static void error(BuildContext context, String message, int duration) {
    show(
      context,
      message: message,
      bgColor: AppPallete.error,
      duration: Duration(seconds: duration),
    );
  }
}

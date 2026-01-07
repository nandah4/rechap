import 'package:flutter/material.dart';
import 'package:rechap/ui/core/themes/app_dimens.dart';
import 'package:rechap/ui/core/themes/app_palette.dart';

const String kFontFamily = 'ProductSans';

// OnBoarding Screen
TextStyle kTitleOnBoard(BuildContext context) => TextStyle(
  color: Theme.of(context).colorScheme.onSurface,
  fontSize: kFontSize24,
  fontWeight: FontWeight.w500,
);

TextStyle kSubTitleOnBoard(BuildContext context) => TextStyle(
  color: Theme.of(context).colorScheme.onSurfaceVariant,
  fontSize: kFontSize16,
  fontWeight: FontWeight.w400,
);

// Login Screen
TextStyle kTitleLogin(BuildContext context) => TextStyle(
  color: Theme.of(context).colorScheme.onSurface,
  fontSize: kFontSize24,
  fontWeight: FontWeight.w500,
);

TextStyle kSubTitleLogin(BuildContext context) => TextStyle(
  color: Theme.of(context).colorScheme.onSurfaceVariant,
  fontSize: kFontSize16,
  fontWeight: FontWeight.w400,
);

/// General
TextStyle kDescription(BuildContext context) => TextStyle(
  color: Theme.of(context).colorScheme.onSurface,
  fontSize: kFontSize16,
  fontWeight: FontWeight.w400,
);

/// Error and Succes Snackbar Style
TextStyle kDescriptionSnackbarNotification(BuildContext context) => TextStyle(
  color: AppPallete.white,
  fontSize: kFontSize18,
  fontWeight: FontWeight.w500,
);

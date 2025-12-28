import 'package:rechap/ui/core/themes/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:rechap/ui/core/themes/app_dimens.dart';

const String kFontFamily = 'ProductSans';

// const kTitleOnboard = TextStyle(
//   color: AppPallete.black,
//   fontSize: kFontSize28,
//   fontWeight: FontWeight.w500,
// );

TextStyle kTitleOnBoard(BuildContext context) => TextStyle(
  color: Theme.of(context).colorScheme.onSurface,
  fontSize: kFontSize28,
  fontWeight: FontWeight.w500,
);

TextStyle kSubTitleOnBoard(BuildContext context) => TextStyle(
  color: Theme.of(context).colorScheme.onSurfaceVariant,
  fontSize: kFontSize18,
  fontWeight: FontWeight.w400,
);

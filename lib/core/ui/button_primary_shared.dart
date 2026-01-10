import 'package:flutter/material.dart';

// Internal Packages
import 'package:rechap/core/themes/app_dimens.dart';

class ButtonPrimaryShared extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? bgColor;
  final Color? textColor;
  final double? radius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final BuildContext? context;
  final bool isLoading;

  const ButtonPrimaryShared({
    super.key,
    required this.text,
    required this.onPressed,
    this.bgColor,
    this.textColor,
    this.radius = kRadius16,
    this.height = kButtonHeight56,
    this.fontSize = kFontSize16,
    this.fontWeight = FontWeight.w500,
    this.context,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            bgColor ?? Theme.of(context).colorScheme.onPrimaryContainer,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!),
        ),
        fixedSize: Size(double.infinity, height!),
      ),
      child: isLoading
          ? CircularProgressIndicator(
              color: Theme.of(context).colorScheme.surface,
              strokeWidth: 2,
            )
          : Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color:
                    textColor ??
                    Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
    );
  }
}

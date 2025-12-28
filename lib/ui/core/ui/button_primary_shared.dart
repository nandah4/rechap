import 'package:flutter/material.dart';
import 'package:rechap/ui/core/themes/app_palette.dart';
import 'package:rechap/ui/core/themes/app_dimens.dart';

class ButtonPrimaryShared extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? bgColor;
  final Color? textColor;
  final double? radius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;

  const ButtonPrimaryShared({
    Key? key,
    required this.text,
    required this.onPressed,
    this.bgColor = AppPallete.blackPrimary,
    this.textColor = AppPallete.white,
    this.radius = kRadius16,
    this.height = kButtonHeight56,
    this.fontSize = kFontSize18,
    this.fontWeight = FontWeight.w500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!),
        ),
        fixedSize: Size(double.infinity, height!),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}

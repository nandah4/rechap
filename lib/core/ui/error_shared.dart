import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_typography.dart';
import 'package:rechap/core/ui/button_primary_shared.dart';

class ErrorShared extends StatelessWidget {
  final String? title;
  final String? description;
  final VoidCallback? onPressed;

  const ErrorShared({super.key, this.title, this.description, this.onPressed});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/images/kittc-chat-error.json',
          width: kImageEmpty,
          height: kImageEmpty,
        ),
        SizedBox(height: kSpacing20),
        Text(title ?? "Failed to load data", style: kTitleEmpty(context)),
        Text(
          description ?? "Refresh to load data again",
          style: kSubtitleEmpty(context),
        ),
        const SizedBox(height: kSpacing20),
        ButtonPrimaryShared(
          text: "Refresh",
          onPressed: () => onPressed,
          height: kButtonHeight48,
          radius: kRadius12,
        ),
      ],
    ),
  );
}

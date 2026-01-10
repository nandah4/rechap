import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_typography.dart';
import 'package:rechap/core/ui/button_primary_shared.dart';
import 'package:lottie/lottie.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: kSpacing16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/images/cat-main-icon.json",
                    width: kLottieSize,
                    height: kLottieSize,
                  ),
                  const SizedBox(height: kSpacing26),
                  Text("Rechap", style: kTitleOnBoard(context)),
                  const SizedBox(height: kSpacing4),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      "A real-time messaging platform built for modern conversations.",
                      style: kSubTitleOnBoard(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: kButtonHeight64,
              width: double.infinity,
              child: ButtonPrimaryShared(
                text: "Get Started",
                onPressed: () => context.goNamed("login-screen"),
              ),
            ),
            const SizedBox(height: kSpacing26),
          ],
        ),
      ),
    );
  }
}

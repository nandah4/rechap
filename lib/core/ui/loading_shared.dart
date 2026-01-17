import 'package:flutter/material.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/core/themes/app_typography.dart';

class LoadingShared extends StatelessWidget {
  const LoadingShared({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: kSpacing52,
            width: kSpacing52,
            child: CircularProgressIndicator(
              color: AppPallete.yellowSecondary,
              strokeWidth: kSpacing4,
            ),
          ),
          SizedBox(height: kSpacing20),
          Text("Loading ...", style: kTitleEmpty(context)),
        ],
      ),
    );
  }
}

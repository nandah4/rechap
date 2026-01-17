import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_typography.dart';

class EmptyWidget extends StatelessWidget {
  final String? title;
  final String? description;

  const EmptyWidget({super.key, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/empty-notif.json',
            width: kImageEmpty,
            height: kImageEmpty,
          ),
          SizedBox(height: kSpacing20),
          Text(title ?? 'Empty Data', style: kTitleEmpty(context)),
          Text(
            description ?? 'Try to fill out to get a data!',
            style: kSubtitleEmpty(context),
          ),
        ],
      ),
    );
  }
}

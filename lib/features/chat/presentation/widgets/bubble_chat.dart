import 'package:flutter/material.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/core/themes/app_typography.dart';

class BubbleChat extends StatelessWidget {
  final String message;
  final bool isSender;
  final DateTime dateTime;
  const BubbleChat({
    super.key,
    required this.message,
    required this.isSender,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * .80;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: kSpacing10,
          horizontal: kSpacing16,
        ),
        decoration: BoxDecoration(
          color: AppPallete.backgroundGrey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kRadius12),
            topRight: Radius.circular(kRadius12),
            bottomLeft: Radius.circular(isSender ? kRadius12 : 0),
            bottomRight: Radius.circular(isSender ? 0 : kRadius12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message, style: kMessage(context)),
            const SizedBox(height: kSpacing8),
            Text(
              "${dateTime.hour}:${dateTime.minute}",
              style: kTimestamp(context),
            ),
          ],
        ),
      ),
    );
  }
}

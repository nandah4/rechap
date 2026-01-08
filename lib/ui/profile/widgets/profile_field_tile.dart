import 'package:flutter/material.dart';

import 'package:rechap/ui/core/themes/app_dimens.dart';
import 'package:rechap/ui/core/themes/app_typography.dart';
import 'package:rechap/ui/core/themes/app_palette.dart';

import 'package:icons_plus/icons_plus.dart';

class ProfileFieldTile extends StatelessWidget {
  final VoidCallback onTap;
  final String? initialValue;
  final bool isClicked;
  final IconData iconTile;

  const ProfileFieldTile({
    super.key,
    required this.onTap,
    required this.isClicked,
    required this.iconTile,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isClicked ? onTap : () {},
      borderRadius: BorderRadius.circular(kRadius16),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: kSpacing20),
            child: Icon(iconTile, size: kFontSize20),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: kSpacing18),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: AppPallete.greyBorder),
                ),
              ),
              child: Row(
                children: [
                  Text(initialValue ?? '-', style: kFieldProfile(context)),

                  if (isClicked) ...[
                    const Spacer(),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: kSpacing16,
                      ),
                      child: Icon(
                        FontAwesome.chevron_right_solid,
                        color: AppPallete.greyText,
                        size: kFontSize18,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_typography.dart';
import 'package:rechap/core/themes/app_palette.dart';

import 'package:icons_plus/icons_plus.dart';

class ProfileFieldTile extends StatelessWidget {
  final VoidCallback onTap;
  final String? initialValue;
  final bool enables;
  final IconData iconTile;

  const ProfileFieldTile({
    super.key,
    required this.onTap,
    required this.enables,
    required this.iconTile,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enables ? onTap : null,
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

                  if (enables) ...[
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

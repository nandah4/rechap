import 'package:flutter/material.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/core/themes/app_typography.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;
  final bool isCenter;
  final String? label;

  const NavItem({
    super.key,
    required this.icon,
    required this.onTap,
    this.label,
    this.isActive = false,
    this.isCenter = false,
  });

  Color _fontColor(BuildContext context) {
    if (isCenter) {
      return Theme.of(context).colorScheme.surface;
    } else if (isActive) {
      return Theme.of(context).colorScheme.onSurface;
    } else {
      return AppPallete.greyText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isCenter
              ? Theme.of(context).colorScheme.onSurface
              : Colors.transparent,
          borderRadius: isCenter ? BorderRadius.circular(kSpacing52) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isCenter) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: kFontSize20, color: _fontColor(context)),
                  const SizedBox(width: kSpacing8),
                  Text(
                    label ?? 'New Chat',
                    style: kDescription(context).copyWith(
                      color: _fontColor(context),
                      fontSize: kFontSize16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ] else ...[
              Icon(icon, color: _fontColor(context), size: kFontSize24),
              if (label != null) ...[
                const SizedBox(height: kSpacing4),
                Text(
                  label!,
                  style: kDescription(
                    context,
                  ).copyWith(color: _fontColor(context), fontSize: kFontSize12),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

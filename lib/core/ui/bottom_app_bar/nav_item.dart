import 'package:flutter/material.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_palette.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;
  final bool isCenter;

  const NavItem({
    super.key,

    required this.icon,
    required this.onTap,
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
          children: [Icon(icon, color: _fontColor(context), size: kFontSize24)],
        ),
      ),
    );
  }
}

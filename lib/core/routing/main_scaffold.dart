import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rechap/core/ui/bottom_app_bar/nav_item.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  int _indexFromLocation(String location) {
    if (location.startsWith('/profile')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _indexFromLocation(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.symmetric(vertical: kSpacing2),
        child: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavItem(
                icon: FontAwesome.comment,
                isActive: currentIndex == 0,
                onTap: () => context.go('/chat-list'),
              ),

              SizedBox(
                height: kSpacing48,
                width: MediaQuery.of(context).size.width * 0.20,
                child: NavItem(
                  icon: FontAwesome.plus_solid,
                  isCenter: true,
                  onTap: () => context.go('/chat-list'),
                ),
              ),

              NavItem(
                icon: FontAwesome.user,
                isActive: currentIndex == 2,
                onTap: () => context.go('/profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

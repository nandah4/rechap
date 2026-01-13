import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/core/themes/app_typography.dart';
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
                width: MediaQuery.of(context).size.width * 0.35,
                child: NavItem(
                  label: 'New Chat',
                  icon: FontAwesome.plus_solid,
                  isCenter: true,
                  onTap: () => showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: .only(bottom: kSpacing30),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(kRadius20),
                          ),
                          margin: EdgeInsets.all(kSpacing16),
                          padding: EdgeInsets.all(kSpacing4),
                          height: 150,
                          child: Column(
                            children: [
                              ListTile(
                                minLeadingWidth: kSpacing36,
                                leading: Icon(
                                  FontAwesome.comments,
                                  size: kSpacing24,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                                subtitle: Text(
                                  "Send a message to your contact",
                                  style: kDescription(context).copyWith(
                                    color: AppPallete.greyText,
                                    fontSize: kFontSize16,
                                  ),
                                ),
                                title: Text(
                                  'Start New Chat',
                                  style: kDescription(context).copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: kFontSize18,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  context.push('/contact-list');
                                },
                              ),
                              Divider(),
                              GestureDetector(
                                onTap: () {
                                  context.pop(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    vertical: kSpacing12,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Cancel',
                                    style: kDescription(context).copyWith(
                                      color: AppPallete.error,
                                      fontSize: kFontSize18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
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

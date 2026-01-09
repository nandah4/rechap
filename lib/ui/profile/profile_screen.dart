import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rechap/ui/core/themes/app_dimens.dart';
import 'package:rechap/ui/core/themes/app_palette.dart';
import 'package:rechap/ui/core/themes/app_typography.dart';
import 'package:rechap/ui/profile/form/edit_field_type.dart';
import 'package:rechap/ui/profile/view_models/profile_view_model.dart';
import 'package:rechap/ui/profile/widgets/edit_field_modal_bottom.dart';
import 'package:rechap/ui/profile/widgets/profile_field_tile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondaryFixed,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.onSecondaryFixed,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: profileData.when(
        data: (user) {
          return Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: kSpacing16),
            child: Column(
              children: [
                const SizedBox(height: kSpacing20),

                // Row profile photo
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: kProfilePhotoSize,
                          width: kProfilePhotoSize,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/profile-photo.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: kSpacing16),
                        Text(
                          "Default Profile Photo",
                          style: kDescription(context),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: kSpacing20),

                //
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kRadius16),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      ProfileFieldTile(
                        onTap: () async {
                          final callResult = await showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (ctx) {
                              return EditFieldModalBottom(
                                fieldType: EditFieldType.name,
                                initialValue: user.username,
                              );
                            },
                          );
                        },
                        enables: true,
                        initialValue: user.username,
                        iconTile: FontAwesome.user,
                      ),
                      ProfileFieldTile(
                        onTap: () async {
                          final callResult = await showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (ctx) {
                              return EditFieldModalBottom(
                                fieldType: EditFieldType.name,
                                initialValue: user.phoneNumber,
                              );
                            },
                          );
                        },
                        enables: false,
                        initialValue: user.phoneNumber,
                        iconTile: FontAwesome.phone_solid,
                      ),
                      ProfileFieldTile(
                        onTap: () async {
                          final callResult = await showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (ctx) {
                              return EditFieldModalBottom(
                                fieldType: EditFieldType.bio,
                                initialValue: user.bio,
                              );
                            },
                          );
                        },
                        enables: true,
                        initialValue: user.bio,
                        iconTile: FontAwesome.quote_left_solid,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kSpacing20),
                Material(
                  borderRadius: BorderRadius.circular(kRadius16),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kRadius16),
                      color: AppPallete.error.withValues(alpha: .50),
                    ),
                    child: InkWell(
                      highlightColor: AppPallete.error,
                      customBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          strokeAlign: 1,
                          width: 1,
                          color: AppPallete.error,
                        ),
                      ),
                      onTap: () {},
                      borderRadius: BorderRadius.circular(kRadius16),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsetsGeometry.symmetric(
                              horizontal: kSpacing20,
                            ),
                            child: Icon(
                              FontAwesome.arrow_right_from_bracket_solid,
                              size: kFontSize20,
                              color: AppPallete.white,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: kSpacing18,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: AppPallete.greyBorder,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Logout",
                                    style: kFieldProfile(
                                      context,
                                    ).copyWith(color: AppPallete.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stack) => Text("Error"),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}

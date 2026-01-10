import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rechap/features/profile/presentation/widgets/field_bottom_sheet_widget/edit_field_config.dart';
import 'package:rechap/features/profile/presentation/widgets/field_bottom_sheet_widget/edit_field_modal_bottom.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/core/themes/app_typography.dart';
import 'package:rechap/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:rechap/features/profile/presentation/widgets/profile_field_tile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  /// Opens edit modal for a specific field
  Future<void> _openEditModal({
    required BuildContext context,
    required EditFieldType fieldType,
    required String? initialValue,
    required WidgetRef ref,
  }) async {
    final result = await showModalBottomSheet<Map<EditFieldType, String>>(
      isScrollControlled: true,
      context: context,
      builder: (_) => EditFieldModalBottom(
        fieldType: fieldType,
        initialValue: initialValue,
      ),
    );

    if (result != null && context.mounted) {
      final EditFieldType fieldType = result.keys.first;
      final String value = result.values.first;

      await ref
          .read(profileViewModelProvider.notifier)
          .updateProfile(fieldType, value);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(profileViewModelProvider);

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
        data: (user) => _buildProfileContent(context, ref, user),
        error: (error, stack) => _buildErrorState(context, ref, error),
        loading: () => _buildLoadingState(),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, WidgetRef ref, user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing16),
      child: Column(
        children: [
          const SizedBox(height: kSpacing20),

          // Profile Photo Section
          _buildProfilePhoto(context),
          const SizedBox(height: kSpacing20),

          // Profile Fields Section
          _buildProfileFields(context, user, ref),
          const SizedBox(height: kSpacing20),

          // Logout Button
          _buildLogoutButton(context, ref),
        ],
      ),
    );
  }

  Widget _buildProfilePhoto(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
            Text("Default Profile Photo", style: kDescription(context)),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileFields(BuildContext context, user, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadius16),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Username field
          ProfileFieldTile(
            onTap: () => _openEditModal(
              context: context,
              fieldType: EditFieldType.name,
              initialValue: user.username,
              ref: ref,
            ),
            enables: true,
            initialValue: user.username,
            iconTile: FontAwesome.user,
          ),
          // Phone number field (read-only)
          ProfileFieldTile(
            onTap: () {}, // No action - read only
            enables: false,
            initialValue: user.phoneNumber,
            iconTile: FontAwesome.phone_solid,
          ),
          // Bio field
          ProfileFieldTile(
            onTap: () => _openEditModal(
              context: context,
              fieldType: EditFieldType.bio,
              initialValue: user.bio,
              ref: ref,
            ),
            enables: true,
            initialValue: user.bio,
            iconTile: FontAwesome.quote_left_solid,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, WidgetRef ref) {
    return Material(
      borderRadius: BorderRadius.circular(kRadius16),
      child: Ink(
        height: kButtonHeight64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadius16),
          color: Theme.of(context).colorScheme.onPrimaryContainer,
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
          onTap: () => _showLogoutConfirmation(context, ref),
          borderRadius: BorderRadius.circular(kRadius16),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSpacing20),
                child: Icon(
                  FontAwesome.arrow_right_from_bracket_solid,
                  size: kFontSize20,
                  color: AppPallete.white,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: kSpacing18),
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
    );
  }

  void _showLogoutConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(kRadius8),
        ),
        title: Text("Logout", style: Theme.of(context).textTheme.headlineSmall),
        content: Text(
          "Are you sure you want to logout?",
          style: kDescription(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel", style: kDescription(context)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(profileViewModelProvider.notifier).signOut();
            },
            child: Text("Logout", style: TextStyle(color: AppPallete.error)),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kSpacing24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: AppPallete.error),
            const SizedBox(height: kSpacing16),
            Text(
              "Failed to load profile",
              style: kLabelProfile(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: kSpacing8),
            Text(
              error.toString(),
              style: kDescription(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: kSpacing24),
            ElevatedButton.icon(
              onPressed: () =>
                  ref.read(profileViewModelProvider.notifier).refresh(),
              icon: const Icon(Icons.refresh),
              label: const Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }
}

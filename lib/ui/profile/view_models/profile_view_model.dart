import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/di/user_di.dart';
import 'package:rechap/domain/entities/user_entity.dart';
import 'package:rechap/ui/profile/models/edit_field_config.dart';

/// Provider for ProfileViewModel
final profileProvider = AsyncNotifierProvider<ProfileViewModel, UserEntity>(
  ProfileViewModel.new,
);

/// ViewModel for Profile Screen
///
/// Handles fetching current user data and logout
class ProfileViewModel extends AsyncNotifier<UserEntity> {
  @override
  FutureOr<UserEntity> build() {
    return ref.read(userUseCaseProvider).getCurrentUser();
  }

  Future<void> updateProfile(EditFieldType type, String value) async {
    final currState = state.value;
    if (currState == null) return;

    state = AsyncData(
      currState.copyWith(
        username: type == EditFieldType.name ? value : currState.username,
        bio: type == EditFieldType.bio ? value : currState.bio,
      ),
    );

    try {
      await ref.read(userUseCaseProvider).updateField(type, value);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  /// Refreshes the user profile data
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(userUseCaseProvider).getCurrentUser(),
    );
  }
}

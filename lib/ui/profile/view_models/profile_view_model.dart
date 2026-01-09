import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/di/user_di.dart';
import 'package:rechap/domain/entities/user_entity.dart';
import 'package:rechap/domain/common/result.dart';

class ProfileState {
  final UserEntity? userData;
  final String? message;

  ProfileState({this.userData, this.message});
}

final profileProvider = AsyncNotifierProvider<ProfileViewModel, UserEntity>(
  ProfileViewModel.new,
);

class ProfileViewModel extends AsyncNotifier<UserEntity> {
  @override
  FutureOr<UserEntity> build() {
    return ref.read(userUseCaseProvider).getCurrentUser();
  }
}

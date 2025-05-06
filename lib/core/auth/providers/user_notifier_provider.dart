import 'package:aisign_project/core/auth/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentUserNotifier extends StateNotifier<UserModel?> {

  CurrentUserNotifier() : super(null);

  void setUser(UserModel? user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}

final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, UserModel?>((ref) {
  return CurrentUserNotifier();
});
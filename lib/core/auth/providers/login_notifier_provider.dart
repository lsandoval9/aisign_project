import 'package:aisign_project/core/auth/errors/login_error.dart';
import 'package:aisign_project/core/auth/models/user_model.dart';
import 'package:aisign_project/core/auth/providers/is_logged_in_provider.dart';
import 'package:aisign_project/core/auth/providers/user_notifier_provider.dart';
import 'package:aisign_project/core/auth/services/auth_service.dart';
import 'package:aisign_project/shared/errors/base/failure_base.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginControllerNotifier extends StateNotifier<AsyncValue<void>> {

  final Ref _ref;

  LoginControllerNotifier(this._ref) : super(AsyncData(null)); // Initial state

  Future<bool?> login(String email, String password) async {

    state = AsyncLoading();

    var authService = AuthService();

    if (email.isEmpty || password.isEmpty) {
      return null;
    }

    var result = await authService.login(
      email: email,
      password: password,
    );

    if (result) {

      state = AsyncData(null);

      _ref.read(currentUserProvider.notifier).setUser(
        UserModel(
          email: email,
          name: email,
          id: "1",
        ),
      );

      _ref.read(isLoggedInProvider.notifier).state = true;

      return true;

    } else {

      _ref.read(currentUserProvider.notifier).setUser(null);

      _ref.read(isLoggedInProvider.notifier).state = false;

      state = AsyncError(
        LoginError(
          message: "Invalid email or password",
          code: 401,
        ),
        StackTrace.current
      );

    }
    return false;

  }


  logout() {
    _ref.read(currentUserProvider.notifier).setUser(null);
    _ref.read(isLoggedInProvider.notifier).state = false;
  }

}

// 2. Define the StateNotifierProvider
final loginControllerProvider = StateNotifierProvider<LoginControllerNotifier, AsyncValue<void>>((ref) {
  return LoginControllerNotifier(ref);
});
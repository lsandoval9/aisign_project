import 'package:flutter_riverpod/flutter_riverpod.dart';


// final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final isLoggedInProvider = StateProvider<bool>((ref) => false);

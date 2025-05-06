

import 'dart:convert';

import 'package:flutter/services.dart';

class AuthService {

  login ({required String email, required String password}) async {

    await Future.delayed(const Duration(seconds: 2));

    var user = await rootBundle.loadString('assets/mocks/user.json', cache: false);

    var jsonUser = jsonDecode(user) as Map<String, dynamic>;

    if (jsonUser['email'] == email && jsonUser['password'] == password) {
      return true;
    } else {
      return false;
    }

  }
}
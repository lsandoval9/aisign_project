


import 'dart:async';

import 'package:aisign_project/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final themeProvider = NotifierProvider<_ThemeNotifier, AppTheme>(() {

  return _ThemeNotifier();
});

class _ThemeNotifier extends Notifier<AppTheme> {

  _ThemeNotifier();

  @override
  AppTheme build() {
    final isDarkMode = false;

    return AppTheme(isDarkMode: isDarkMode);
  }

  void toggleTheme(bool? isDarkMode) async {

    if (isDarkMode == null) {

      state = AppTheme(isDarkMode: state.isDarkMode);

    } else {

      state = AppTheme(isDarkMode: isDarkMode);

    }

  }



}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmptyLayout extends StatelessWidget {

  final Widget child;

  const EmptyLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.primary,
        statusBarIconBrightness: Brightness.light,
        systemStatusBarContrastEnforced: true,
      ),
    );

    return Scaffold(
      body: child,
    );
  }
}
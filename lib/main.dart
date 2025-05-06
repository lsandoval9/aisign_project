import 'package:aisign_project/config/router/app_router_provider.dart';
import 'package:aisign_project/core/auth/providers/is_logged_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
      ProviderScope(
        child: MyApp(),
      )
  );
}

class MyApp extends ConsumerWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bool isLoggedIn = ref.watch(isLoggedInProvider);
    
    final GoRouter goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: "PDF Annotator for AI sign",
      routerConfig: goRouter,
      locale:  const Locale('en', 'US'),
    );
  }
}
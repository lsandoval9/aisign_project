import 'package:aisign_project/core/auth/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    return MaterialApp(
      title: 'PDF Annotator for AI sign',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: null,
    );
  }
}
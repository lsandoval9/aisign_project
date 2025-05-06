import 'package:aisign_project/config/enums/routes_enum.dart';
import 'package:aisign_project/core/auth/providers/is_logged_in_provider.dart';
import 'package:aisign_project/core/auth/screens/login_screen.dart';
import 'package:aisign_project/core/layouts/content/content_layout.dart';
import 'package:aisign_project/core/layouts/empty/empty_layout.dart';
import 'package:aisign_project/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/pdf_handler/presentation/screens/pdf_selection_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {

  final loggedIn = ref.watch(isLoggedInProvider);

  final rootKey = GlobalKey<NavigatorState>();

  final shellKey = GlobalKey<NavigatorState>();

  return GoRouter(

    initialLocation: RoutesEnum.login.path,

    debugLogDiagnostics: true,

    redirect: (BuildContext context, GoRouterState state) {

      final bool loggingIn = state.matchedLocation == RoutesEnum.login.path;

      if (!loggedIn && !loggingIn) {
        return RoutesEnum.login.path;
      }

      if (loggedIn && loggingIn) {
        return RoutesEnum.dashboard.path;
      }

      return null;
    },

    // Define application routes
    routes: [
      // auth shell
      ShellRoute(
          navigatorKey: shellKey,
          builder: (context, state, child) {
            return EmptyLayout(
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: RoutesEnum.login.path,
              builder: (context, state) => LoginScreen(),
            ),
      ]),
      // main shell
      ShellRoute(
          builder: (context, state, child) {
            return ContentLayout(
              child: child,
            );
          },
          routes: [
            GoRoute(
              name: RoutesEnum.dashboard.name,
              path: RoutesEnum.dashboard.path,
              builder: (context, state) => DashboardScreen(),
            ),
            GoRoute(
              name: RoutesEnum.pdfViewer.name,
              path: RoutesEnum.pdfViewer.path,
              builder: (context, state) {

                final pdfPath = state.extra as String?;

                if (pdfPath == null || pdfPath.isEmpty) {
                  return Scaffold(
                    body: Center(
                      child: Text('No PDF path provided'),
                    ),
                  );
                }

                return PdfViewerScreen(pdfPath: pdfPath);
              },
            )
          ]),
    ],
    // Optional: Error handler page
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.error}'),
      ),
    ),
  );
});
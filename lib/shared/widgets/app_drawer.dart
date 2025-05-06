import 'package:aisign_project/config/enums/routes_enum.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Helper to navigate and close the drawer
    void navigate(String route) {
      Navigator.of(context).pop(); // Close the drawer
      context.go(route); // Navigate using GoRouter
    }

    // Get current route to potentially highlight the active item
    final String currentRoute = GoRouterState.of(context).uri.toString();


    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'App Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            selected: currentRoute == RoutesEnum.dashboard.path,
            onTap: () => navigate(RoutesEnum.dashboard.path),
          ),
          // Add more navigation items here
        ],
      ),
    );
  }
}
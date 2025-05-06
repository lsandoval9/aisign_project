
import 'package:aisign_project/config/router/theme_provider.dart';
import 'package:aisign_project/core/layouts/content/widgets/custom_drawer_header.dart';
import 'package:aisign_project/core/layouts/content/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  const CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  bool _isUserPanelExpanded = false;

  VoidCallback get toggleUserPanel => () {
    setState(() {
      _isUserPanelExpanded = !_isUserPanelExpanded;
    });
  };

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    final themeNotifier = ref.watch(themeProvider);

    return SafeArea(
      child: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ListView(
                shrinkWrap: true,
                // disable bounce effect but allowing scrolling
                physics: const ClampingScrollPhysics(),
                children: [
                  CustomDrawerHeader(
                    toggleUserPanel: toggleUserPanel,
                    isUserPanelExpanded: _isUserPanelExpanded,
                  ),
                  const DrawerMenuItems(),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              color: Theme.of(context).colorScheme.surface,
              child: SwitchListTile(
                title: const Text('Dark Mode'),
                value: themeNotifier.isDarkMode,
                onChanged: (value) {
                  ref.read(themeProvider.notifier).toggleTheme(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
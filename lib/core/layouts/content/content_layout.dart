import 'package:aisign_project/core/layouts/content/widgets/bottom_navigation.dart';
import 'package:aisign_project/core/layouts/content/widgets/custom_drawer.dart';
import 'package:aisign_project/core/layouts/content/widgets/floating_add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class ContentLayout extends ConsumerWidget {
  final Widget child;

  const ContentLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return Scaffold(
      floatingActionButton: FloatingAddButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          if (ModalRoute.of(context)!.canPop) {
            return IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () => context.pop(),
            );
          }

          return IconButton(
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        }),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: theme.colorScheme.primary,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
          child: child),
      drawer: const CustomDrawer(),
      drawerEnableOpenDragGesture: false,
    );
  }
}



import 'package:aisign_project/config/enums/routes_enum.dart';
import 'package:aisign_project/core/auth/providers/login_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends ConsumerStatefulWidget {

  const CustomBottomNavigationBar({super.key});

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();

}


class _CustomBottomNavigationBarState extends ConsumerState<CustomBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {

    return BottomAppBar(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      color: Colors.cyan.shade400,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.black,
            ),
            onPressed: () {
              context.goNamed(
                RoutesEnum.dashboard.name,
                extra: null,
              );
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
          ),
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              this.ref.read(loginControllerProvider.notifier).logout();
            },
          ),
        ],
      ),
    );

  }



}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDrawerHeader extends ConsumerWidget {
  final VoidCallback toggleUserPanel;
  final bool isUserPanelExpanded;

  const CustomDrawerHeader(
      {super.key,
        required this.toggleUserPanel,
        required this.isUserPanelExpanded});

  @override
  Widget build(BuildContext context, ref) {
    final titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: Theme.of(context).colorScheme.onSurface,
    );


    return DrawerHeader(
        padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
        margin: const EdgeInsets.only(bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
                  margin: const EdgeInsets.all(0),
                  child: Image.asset("assets/images/logos/dorata-full-logo.png",
                      width: double.infinity, fit: BoxFit.contain),
                ),
              ),
            ),
            ListTile(
              onTap: toggleUserPanel,
              title: Text(
                "Maria Marta sanchez ramirez",
                style: titleStyle,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
              leading: const CircleAvatar(
                backgroundImage:
                AssetImage("assets/images/avatar/profile.jpg"),
              ),
              trailing: Icon(isUserPanelExpanded
                  ? Icons.arrow_drop_up
                  : Icons.arrow_drop_down),
            ),
          ],
        ));
  }
}
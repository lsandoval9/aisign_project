import 'package:aisign_project/config/enums/routes_enum.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerMenuItems extends StatelessWidget {
  const DrawerMenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    defaultText(String text) => Text(
      text,
      style: theme.textTheme.titleMedium?.copyWith(
        fontSize: 18,
      ),
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    );

    final titleStyle = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    final subTitleStyle = theme.textTheme.titleSmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
          child: ListTile(
            title: Text(
              "Navigation menu",
              style: titleStyle,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text("Elementos Principales", style: subTitleStyle),
            tileColor: theme.colorScheme.primary,
            textColor: theme.colorScheme.onPrimary,
          ),
        ),
        ListTile(
          title: defaultText("Dashboard"),
          leading: const Icon(Icons.search_rounded),
          onTap: () {
            context.go(RoutesEnum.dashboard.path);
          },
        ),

      ],
    );
  }
}
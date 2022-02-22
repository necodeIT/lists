import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:lists/db/db.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/routes/lists/list.dart';
import 'package:nekolib_ui/core.dart';

class ListsRoute extends StatefulWidget {
  const ListsRoute({Key? key}) : super(key: key);

  static const String routeName = '/lists';

  @override
  State<ListsRoute> createState() => _ListsRouteState();
}

class _ListsRouteState extends State<ListsRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(NcSpacing.smallSpacing),
      color: secondaryColor,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextBox(
                  placeholder: "Search lists...",
                  suffix: Icon(FluentIcons.search),
                ),
              ),
              NcSpacing.small(),
              Tooltip(
                message: "Create new list",
                child: IconButton(
                  icon: Icon(
                    FluentIcons.add,
                    color: textColor,
                  ),
                  onPressed: () => showCreateNewListDialog(context),
                ),
              ),
              Tooltip(
                message: "Open settigns",
                child: IconButton(
                  icon: Icon(
                    FluentIcons.settings,
                    color: textColor,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          NcSpacing.medium(),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                runSpacing: NcSpacing.smallSpacing,
                spacing: NcSpacing.smallSpacing,
                children: [
                  for (var list in DB.collections) CollectionTile(collection: list),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

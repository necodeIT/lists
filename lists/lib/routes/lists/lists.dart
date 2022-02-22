import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:lists/db/db.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/routes/lists/list.dart';
import 'package:lists/widgets/searchbar.dart';
import 'package:lists/widgets/tooltip_icon_button.dart';
import 'package:nekolib_ui/core.dart';

class ListsRoute extends StatefulWidget {
  const ListsRoute({Key? key}) : super(key: key);

  static const String routeName = '/lists';

  @override
  State<ListsRoute> createState() => _ListsRouteState();
}

class _ListsRouteState extends State<ListsRoute> {
  String _query = "";

  _updateQuery(String query) {
    setState(() {
      _query = query;
    });
  }

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
              Searchbar(
                placeholder: "Search lists...",
                onQuery: _updateQuery,
              ),
              NcSpacing.small(),
              TooltipIconButton(
                tooltip: "Create new list",
                icon: FluentIcons.add,
                onPressed: () => showCreateNewListDialog(context),
              ),
              TooltipIconButton(
                tooltip: "Open settigns",
                icon: FluentIcons.settings,
              ),
            ],
          ),
          NcSpacing.medium(),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Wrap(
                  runSpacing: NcSpacing.smallSpacing,
                  spacing: NcSpacing.smallSpacing,
                  children: [
                    for (var list in DB.collections)
                      if (list.name.contains(_query)) CollectionTile(collection: list),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

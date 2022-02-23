import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:lists/db/collection.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/routes/list/entry_tile.dart';
import 'package:lists/routes/lists/lists.dart';
import 'package:lists/widgets/searchbar.dart';
import 'package:lists/widgets/tooltip_icon_button.dart';
import 'package:nekolib_ui/core.dart';

class ListRoute extends StatefulWidget {
  const ListRoute({Key? key}) : super(key: key);

  static const String routeName = '/list';

  @override
  State<ListRoute> createState() => _CollectionRouteState();
}

class _CollectionRouteState extends State<ListRoute> {
  String _query = '';

  _updateQuery(String value) {
    setState(() {
      _query = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var collection = ModalRoute.of(context)!.settings.arguments as Collection;

    return Container(
      color: secondaryColor,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: 200,
            color: primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TooltipIconButton(
                  tooltip: 'Add new list',
                  icon: FluentIcons.add,
                  onPressed: () => showCreateNewListDialog(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TooltipIconButton(
                        tooltip: "Go back to overview",
                        icon: FluentIcons.back,
                        onPressed: () => Navigator.of(context).pushNamed(ListsRoute.routeName),
                      ),
                      NcSpacing.xs(),
                      Searchbar(
                        placeholder: "Search in ${collection.name}...",
                        onQuery: _updateQuery,
                      ),
                      NcSpacing.small(),
                      TooltipIconButton(
                        tooltip: "Add new entry",
                        icon: FluentIcons.add,
                        onPressed: () => showCreateNewEntryDialog(context, collection),
                      ),
                      TooltipIconButton(
                        tooltip: "Open settigns",
                        icon: FluentIcons.settings,
                      ),
                    ],
                  ),
                  NcSpacing.medium(),
                  Expanded(
                    child: ListView(
                      children: [
                        for (var entry in collection.entries)
                          if (entry.key.contains(_query)) EntryTile(entry: entry)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:lists/db/collection.dart';
import 'package:lists/fluent_icons.dart';
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
  late Collection _collection;
  late String password;

  _updateQuery(String value) {
    setState(() {
      _query = value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _collection.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _collection = routeArgs["collection"] as Collection;
    password = routeArgs["password"] as String;

    return Container(
      color: secondaryColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(NcSpacing.smallSpacing),
            decoration: BoxDecoration(
              color: primaryColor,
              boxShadow: kElevationToShadow[1],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                TooltipIconButton(
                  tooltip: "Go back to overview",
                  icon: FluentIcons.ic_fluent_arrow_up_24_filled,
                  onPressed: () => Navigator.of(context).pushNamed(ListsRoute.routeName),
                ),
                NcSpacing.xs(),
                Searchbar(
                  placeholder: "Search in ${_collection.name}...",
                  onQuery: _updateQuery,
                ),
                NcSpacing.small(),
                TooltipIconButton(
                  tooltip: "Add new entry",
                  icon: FluentIcons.ic_fluent_add_24_filled,
                  onPressed: () => showCreateNewEntryDialog(context, password, _collection),
                ),
                TooltipIconButton(
                  tooltip: "Open settigns",
                  icon: FluentIcons.ic_fluent_settings_24_regular,
                  onPressed: () => showSettingsDialog(context),
                ),
              ],
            ),
          ),
          NcSpacing.medium(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(NcSpacing.smallSpacing),
              child: FutureBuilder(
                future: _collection.load(password),
                builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: ProgressRing(
                          backgroundColor: Colors.transparent,
                        ),
                      )
                    : ListView(
                        controller: ScrollController(),
                        children: [
                          for (var entry in _collection.entries)
                            if (entry.key.contains(_query)) EntryTile(entry: entry)
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

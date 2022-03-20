import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/models/collection.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/helpers/string.dart';
import 'package:lists/view/routes/list/entry_tile.dart';
import 'package:lists/view/routes/lists/lists.dart';
import 'package:lists/view/widgets/searchbar.dart';
import 'package:lists/view/widgets/tooltip_icon_button.dart';
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
  late String _password;

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
    _password = routeArgs["password"] as String;

    return Container(
      color: primaryColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(NcSpacing.smallSpacing),
            decoration: BoxDecoration(
              color: secondaryColor,
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
                  onPressed: () => showCreateNewEntryDialog(context, _password, _collection),
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
                future: _collection.load(_password),
                builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: ProgressRing(
                          backgroundColor: Colors.transparent,
                        ),
                      )
                    : ListView(
                        controller: ScrollController(),
                        children: [
                          for (var entry in _collection.entries.keys.toList())
                            if (entry.containsIgnoreCase(_query)) EntryTile(entry: entry, collection: _collection, password: _password)
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

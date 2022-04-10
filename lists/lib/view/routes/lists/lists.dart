import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/generated/l10n.dart';
import 'package:lists/models/db.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/view/routes/lists/list.dart';
import 'package:lists/view/widgets/searchbar.dart';
import 'package:lists/view/widgets/tooltip_icon_button.dart';
import 'package:nekolib_ui/core.dart';
import 'package:lists/helpers/string.dart';

/// Displays all the user's collections.
class ListsRoute extends StatefulWidget {
  /// Displays all the user's collections.
  const ListsRoute({Key? key}) : super(key: key);

  /// The name of the route.
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
      color: primaryColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(NcSpacing.smallSpacing),
            decoration: BoxDecoration(
              color: secondaryColor,
              // boxShadow: kElevationToShadow[1],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Searchbar(
                  placeholder: S.of(context).searchLists,
                  onQuery: _updateQuery,
                ),
                NcSpacing.small(),
                TooltipIconButton(
                  tooltip: S.of(context).createNewList,
                  icon: FluentIcons.ic_fluent_add_24_filled,
                  onPressed: () => showCreateNewListDialog(context),
                ),
                TooltipIconButton(
                  tooltip: S.of(context).openSettigns,
                  icon: FluentIcons.ic_fluent_settings_24_regular,
                  onPressed: () => showSettingsDialog(context),
                ),
              ],
            ),
          ),
          NcSpacing.small(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(NcSpacing.smallSpacing),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: NcSpacing.smallSpacing,
                  runSpacing: NcSpacing.smallSpacing,
                  children: [
                    for (var list in DB.collections)
                      if (list.name.containsIgnoreCase(_query)) CollectionTile(collection: list),
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

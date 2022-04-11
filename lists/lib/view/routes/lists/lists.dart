import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/helpers/string.dart';
import 'package:lists/models/db.dart';
import 'package:lists/view/routes/lists/list.dart';
import 'package:lists/view/widgets/localized_widget.dart';
import 'package:lists/view/widgets/searchbar.dart';
import 'package:lists/view/widgets/tooltip_icon_button.dart';
import 'package:nekolib_ui/core.dart';

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
    return AppBar(
      onAdd: showCreateNewListDialog,
      placeholder: t.searchLists,
      onQuerry: _updateQuery,
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
    );
  }
}

/// Appbar with settings button, add button, arrow button and a search bar.
class AppBar extends LocalizedWidget {
  /// Appbar with settings button, add button, arrow button and a search bar.
  const AppBar({Key? key, required this.child, required this.onQuerry, this.showArrow = false, required this.placeholder, required this.onAdd}) : super(key: key);

  /// The child of the app bar.
  final Widget child;

  /// Called when the user types in the search bar.
  final Function(String) onQuerry;

  /// Whether to show the arrow icon.
  final bool showArrow;

  /// The placeholder of the search bar.
  final String placeholder;

  /// Called when the user clicks the add button
  final Function(BuildContext) onAdd;

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
                  placeholder: placeholder,
                  onQuery: onQuerry,
                ),
                NcSpacing.small(),
                TooltipIconButton(
                  tooltip: t.createNewList,
                  icon: FluentIcons.ic_fluent_add_24_filled,
                  onPressed: () => onAdd(context),
                ),
                TooltipIconButton(
                  tooltip: t.openSettigns,
                  icon: FluentIcons.ic_fluent_settings_24_regular,
                  onPressed: () => showSettingsDialog(context),
                ),
              ],
            ),
          ),
          NcSpacing.small(),
          Expanded(child: child),
        ],
      ),
    );
  }
}

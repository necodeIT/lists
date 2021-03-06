import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lists/controller/controller.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/helpers/string.dart';
import 'package:lists/main.dart';
import 'package:lists/view/routes/list/entry_tile.dart';
import 'package:lists/view/routes/lists/lists.dart';
import 'package:lists/view/widgets/searchbar.dart';
import 'package:lists/view/widgets/tooltip_icon_button.dart';
import 'package:nekolib_ui/core.dart';

/// Displays all the entries of a collection.
class ListRoute extends ConsumerStatefulWidget {
  /// Displays all the entries of a collection.
  const ListRoute({Key? key}) : super(key: key);

  /// The name of the route.
  static const String routeName = '/list';

  @override
  ConsumerState<ListRoute> createState() => _CollectionRouteState();
}

class _CollectionRouteState extends ConsumerState<ListRoute> with RouteAware {
  String _query = '';
  late String _password;
  late String _name;

  void _dispose() {
    _password = "";
    _name = "";
    _query = "";
    ref.read(collectionProvider).reset();
  }

  @override
  didPop() => _dispose();

  @override
  void didPushNext() {
    _dispose();
    super.didPopNext();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    _dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  _updateQuery(String value) {
    setState(() {
      _query = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    _name = routeArgs["collection"] as String;
    _password = routeArgs["password"] as String;

    ref.read(collectionProvider).set(_name, _password, context);

    return Consumer(
      builder: (context, ref, child) {
        var collection = ref.watch(collectionProvider);

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
                      placeholder: "Search in ${collection.name}...",
                      onQuery: _updateQuery,
                    ),
                    NcSpacing.small(),
                    TooltipIconButton(
                      tooltip: "Add new entry",
                      icon: FluentIcons.ic_fluent_add_24_filled,
                      onPressed: collection.createNewEntry,
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
                  child: !collection.loaded
                      ? Center(
                          child: ProgressRing(
                            backgroundColor: Colors.transparent,
                          ),
                        )
                      : ListView(
                          controller: ScrollController(),
                          children: [
                            for (var entry in collection.entries.keys.toList())
                              if (entry.containsIgnoreCase(_query)) EntryTile(entry: entry, value: collection.entries[entry]!, password: _password)
                          ],
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

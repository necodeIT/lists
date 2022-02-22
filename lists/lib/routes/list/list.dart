import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:lists/db/collection.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/routes/lists/lists.dart';
import 'package:nekolib_ui/core.dart';

class ListRoute extends StatefulWidget {
  const ListRoute({Key? key}) : super(key: key);

  static const String routeName = '/list';

  @override
  State<ListRoute> createState() => _CollectionRouteState();
}

class _CollectionRouteState extends State<ListRoute> {
  @override
  Widget build(BuildContext context) {
    var collection = ModalRoute.of(context)!.settings.arguments as Collection;

    return Container(
      color: secondaryColor,
      padding: EdgeInsets.all(NcSpacing.smallSpacing),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Tooltip(
                message: "Go back to overview",
                child: IconButton(
                  icon: Icon(
                    FluentIcons.back,
                    color: textColor,
                  ),
                  onPressed: () => Navigator.of(context).pushNamed(ListsRoute.routeName),
                ),
              ),
              NcSpacing.xs(),
              Expanded(
                child: TextBox(
                  placeholder: "Search in ${collection.name}...",
                  suffix: Icon(FluentIcons.search),
                ),
              ),
              NcSpacing.small(),
              Tooltip(
                message: "Add new entry",
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
        ],
      ),
    );
  }
}

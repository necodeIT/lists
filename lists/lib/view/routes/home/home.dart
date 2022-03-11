import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/view/routes/home/card.dart';
import 'package:nekolib_ui/core.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NcCaptionText(
            "You do not have any lists yet!",
            fontSize: 25,
          ),
          NcSpacing.xl(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeCard(
                onTap: () => showCreateNewListDialog(context),
                title: "Create your first list",
                icon: FluentIcons.ic_fluent_add_circle_24_filled,
              ),
              NcSpacing.xl(),
              NcCaptionText("or", fontSize: 20),
              NcSpacing.xl(),
              HomeCard(
                onTap: () => showCreateNewListDialog(context),
                title: "Login and sync lists",
                icon: FluentIcons.ic_fluent_arrow_sync_circle_24_filled,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

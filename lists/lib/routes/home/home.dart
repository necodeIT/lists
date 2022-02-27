import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/db/updater.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/routes/home/svg.dart';
import 'package:lists/widgets/info_box_container.dart';
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
              GestureDetector(
                onTap: () => showCreateNewListDialog(context),
                child: Container(
                  width: 250,
                  height: 300,
                  decoration: InfoBoxContainer.decoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FluentIcons.ic_fluent_add_circle_24_filled, size: 60),
                      NcSpacing.medium(),
                      NcBodyText(
                        "Create your first list",
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
              ),
              NcSpacing.xl(),
              NcCaptionText("or", fontSize: 20),
              NcSpacing.xl(),
              GestureDetector(
                onTap: () => showCreateNewListDialog(context),
                child: Container(
                  width: 250,
                  height: 300,
                  decoration: InfoBoxContainer.decoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FluentIcons.ic_fluent_arrow_sync_circle_24_filled, size: 60),
                      NcSpacing.medium(),
                      NcBodyText(
                        "Login and sync lists",
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

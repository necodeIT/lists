import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/db/db.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/routes/home/svg.dart';
import 'package:nekolib_ui/core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const String route = '/';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryColor,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: NcVectorImage(
              code: noListsSvg,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NcCaptionText(
                  "You do not have any lists yet!",
                  fontSize: 20,
                ),
                NcSpacing.medium(),
                FilledButton(
                  child: NcBodyText(
                    "Create your first list",
                    buttonText: true,
                  ),
                  style: filledButtonStyle(),
                  onPressed: () => showCreateNewListDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/home/svg.dart';
import 'package:nekolib_ui/core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _checkedTheme = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_checkedTheme) {
      _checkedTheme = true;
      NcThemes.setTheme(MediaQuery.of(context).platformBrightness == Brightness.dark ? darkTheme : lightTheme);
    }

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
                    "Create a new list",
                    buttonText: true,
                  ),
                  style: ButtonStyle(
                    backgroundColor: ButtonState.all(accentColor),
                  ),
                  onPressed: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

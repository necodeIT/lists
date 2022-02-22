import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/db/db.dart';
import 'package:lists/routes/home/home.dart';
import 'package:lists/routes/lists/lists.dart';
import 'package:nekolib_ui/core.dart';

void main() {
  NcThemes.setTheme(darkTheme);
  runThemedApp((context) => App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      theme: ThemeData(
        brightness: brightness,
      ),
      title: 'Lists',
      initialRoute: DB.collections.isNotEmpty ? Lists.route : Home.route,
      routes: {
        Home.route: (context) => Home(),
        Lists.route: (context) => Lists(),
      },
    );
  }
}

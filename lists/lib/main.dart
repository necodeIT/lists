import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/db/db.dart';
import 'package:lists/helpers/app_loader.dart';
import 'package:lists/helpers/system_theme.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:lists/routes/home/home.dart';
import 'package:lists/routes/lists/lists.dart';
import 'package:nekolib_ui/core.dart';
import 'package:system_theme/system_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemThemeObserver.start();

  runApp(
    FutureBuilder(
      future: loadAll(),
      builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting ? appLoader() : NcApp(builder: (context) => App()),
    ),
  );
}

Future loadAll() async {
  // await DB.load();
  await Future.delayed(Duration(seconds: 10));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      theme: ThemeData(
        brightness: brightness,
        scaffoldBackgroundColor: secondaryColor,
        accentColor: accentColors.value,
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

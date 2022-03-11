import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/db/db.dart';
import 'package:lists/db/settings.dart';
import 'package:lists/db/updater.dart';
import 'package:lists/helpers/app_loader.dart';
import 'package:lists/helpers/system_theme.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:lists/routes/home/home.dart';
import 'package:lists/routes/list/list.dart';
import 'package:lists/routes/lists/lists.dart';
import 'package:lists/routes/upgrade/upgrade.dart';
import 'package:nekolib_ui/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NcThemes.initPredefinedThemes();

  await Settings.load();
  SystemThemeObserver.start();

  runApp(
    FutureBuilder(
      future: loadAll(),
      builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting ? appLoader() : NcApp(builder: (context) => App()),
    ),
  );
}

Future loadAll() async {
  await Updater.update();
  await DB.load();
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      title: 'Lists',
      initialRoute: Updater.updateAvailable
          ? UpgradeRoute.routeName
          : DB.collections.isNotEmpty
              ? ListsRoute.routeName
              : HomeRoute.routeName,
      routes: {
        HomeRoute.routeName: (context) => ContextMenuOverlay(child: HomeRoute()),
        ListsRoute.routeName: (context) => ContextMenuOverlay(child: ListsRoute()),
        ListRoute.routeName: (context) => ContextMenuOverlay(child: ListRoute()),
        UpgradeRoute.routeName: (context) => ContextMenuOverlay(child: UpgradeRoute()),
      },
    );
  }
}

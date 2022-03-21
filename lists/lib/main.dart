import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lists/models/db.dart';
import 'package:lists/models/settings.dart';
import 'package:lists/models/updater.dart';
import 'package:lists/helpers/app_loader.dart';
import 'package:lists/helpers/system_theme.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:lists/view/routes/home/home.dart';
import 'package:lists/view/routes/list/list.dart';
import 'package:lists/view/routes/lists/lists.dart';
import 'package:lists/view/routes/upgrade/upgrade.dart';
import 'package:lists/view/widgets/route.dart';
import 'package:lists/view/widgets/window_handle.dart';
import 'package:nekolib_ui/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NcThemes.initPredefinedThemes();

  SystemThemeObserver.start();
  await Settings.load();

  runApp(
    FutureBuilder(
      future: loadAll(),
      builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting ? appLoader() : NcApp(builder: (context) => App()),
    ),
  );

  doWhenWindowReady(() {
    var size = Size(1200, 700);
    appWindow.size = size;
    appWindow.minSize = size;
    appWindow.title = Updater.appName;
    appWindow.show();
  });
}

Future loadAll() async {
  await Updater.update();
  await DB.load();
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: FluentApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        title: 'Lists',
        builder: WindowHandle.builder,
        initialRoute: Updater.updateAvailable
            ? UpgradeRoute.routeName
            : DB.collections.isNotEmpty
                ? ListsRoute.routeName
                : HomeRoute.routeName,
        routes: {
          HomeRoute.routeName: (context) => Route(child: HomeRoute()),
          ListsRoute.routeName: (context) => Route(child: ListsRoute()),
          ListRoute.routeName: (context) => Route(child: ListRoute()),
          UpgradeRoute.routeName: (context) => Route(child: UpgradeRoute()),
        },
      ),
    );
  }
}

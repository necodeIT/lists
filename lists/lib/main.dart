import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lists/models/db.dart';
import 'package:lists/models/settings.dart';
import 'package:lists/models/updater.dart';
import 'package:lists/helpers/app_loader.dart';
import 'package:lists/helpers/system_theme.dart';
import 'package:lists/view/styles/styles.dart';
import 'package:lists/view/routes/home/home.dart';
import 'package:lists/view/routes/list/list.dart';
import 'package:lists/view/routes/lists/lists.dart';
import 'package:lists/view/routes/upgrade/upgrade.dart';
import 'package:lists/view/widgets/route.dart';
import 'package:lists/view/widgets/window_handle.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_utils/log.dart';

/// Used to dispose collection when the user navigates away from [ListRoute].
final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

void main() async {
  Logger.init(autoSave: true, appStoragePath: (await DB.appDir).path);

  WidgetsFlutterBinding.ensureInitialized();
  NcThemes.initPredefinedThemes();

  SystemThemeObserver.start();
  await Settings.load();

  runThemedApp(
    appBuilder: App.builder,
    loadingWidgetBuilder: appLoader,
    onLoad: loadAll(),
  );

  doWhenWindowReady(() {
    var size = Size(1200, 700);

    appWindow
      ..minSize = size
      ..title = Updater.appName
      ..show();
  });
}

/// Loads all the data needed for the app.
Future loadAll() async {
  await Updater.update();
  await DB.load();
}

/// The app.
class App extends StatelessWidget {
  ///
  const App({Key? key}) : super(key: key);

  /// Builder for the app.
  static Widget builder(context) => App();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: FluentApp(
        navigatorObservers: [routeObserver],
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

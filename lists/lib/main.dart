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
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_utils/log.dart';

/// Used to dispose collection when the user navigates away from [ListRoute].
final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

void main() async {
  Logger.init(autoSave: true, appStoragePath: (await DB.appDir).path);

  WidgetsFlutterBinding.ensureInitialized();
  NcThemes.initPredefinedThemes();

  SystemThemeObserver.start();

  runThemedApp(
    appBuilder: App.builder,
    loadingWidgetBuilder: appLoader,
    onLoad: loadAll,
    title: Updater.appName,
    appIcon: kAppIconSvg,
    minSize: Size(1200, 700),
  );
}

/// Loads all the data needed for the app.
Future loadAll() async {
  await Settings.load();
  await Updater.update();
  await DB.load();
}

/// The main app widget.
class App extends StatelessWidget {
  /// The main app widget.
  const App({Key? key}) : super(key: key);

  /// Builder for the app.
  static Widget builder(context) => App();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: FluentApp(
        locale: Locale('en'),
        navigatorObservers: [routeObserver],
        debugShowCheckedModeBanner: false,
        theme: theme(),
        title: 'Lists',
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

/// The app icon.
const kAppIconSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="338.5" height="291" viewBox="0 0 338.5 291">
  <defs>
    <linearGradient id="linear-gradient" x1="0.047" y1="0.039" x2="0.953" y2="0.96" gradientUnits="objectBoundingBox">
      <stop offset="0" stop-color="#f3a39e"/>
      <stop offset="1" stop-color="#c2827e"/>
    </linearGradient>
    <filter id="Background" x="0" y="0" width="291" height="291" filterUnits="userSpaceOnUse">
      <feOffset dy="3" input="SourceAlpha"/>
      <feGaussianBlur stdDeviation="26.5" result="blur"/>
      <feFlood flood-opacity="0.51"/>
      <feComposite operator="in" in2="blur"/>
      <feComposite in="SourceGraphic"/>
    </filter>
  </defs>
  <g id="Icon" transform="translate(79.83 20.467)">
    <g id="Stripes" transform="translate(59.952 0.143)">
      <path id="Rectangle_44" data-name="Rectangle 44" d="M0,0H199a0,0,0,0,1,0,0V34a26,26,0,0,1-26,26H26A26,26,0,0,1,0,34V0A0,0,0,0,1,0,0Z" transform="translate(-0.282 180.89)" fill="#aa726f"/>
      <rect id="Rectangle_43" data-name="Rectangle 43" width="199" height="59" transform="translate(-0.282 121.89)" fill="#c2827e"/>
      <rect id="Rectangle_45" data-name="Rectangle 45" width="199" height="59" transform="translate(-0.282 62.89)" fill="#db938e"/>
      <path id="Rectangle_41" data-name="Rectangle 41" d="M26,0H173a26,26,0,0,1,26,26V63a0,0,0,0,1,0,0H0a0,0,0,0,1,0,0V26A26,26,0,0,1,26,0Z" transform="translate(-0.282 -0.11)" fill="#f3a39e"/>
    </g>
    <g id="Name" transform="translate(0.099 56.341)">
      <g transform="matrix(1, 0, 0, 1, -79.93, -76.81)" filter="url(#Background)">
        <rect id="Background-2" data-name="Background" width="132" height="132" rx="26" transform="translate(79.5 76.5)" fill="url(#linear-gradient)"/>
      </g>
      <text id="L" transform="translate(38.571 100.693)" fill="rgba(255,255,255,0.87)" font-size="101" font-family="Roboto-Medium, Roboto" font-weight="500" letter-spacing="0.008em"><tspan x="0" y="0">L</tspan></text>
    </g>
  </g>
</svg>
''';

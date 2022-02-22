import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/db/db.dart';
import 'package:lists/helpers/app_loader.dart';
import 'package:lists/helpers/system_theme.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:lists/routes/home/home.dart';
import 'package:lists/routes/list/list.dart';
import 'package:lists/routes/lists/lists.dart';
import 'package:nekolib_ui/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemThemeObserver.start();
  // NcThemes.setTheme(sakuraTheme);

  runApp(
    FutureBuilder(
      future: loadAll(),
      builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting ? appLoader() : NcApp(builder: (context) => App()),
    ),
  );
}

Future loadAll() async {
  await DB.load();
  await Future.delayed(Duration(seconds: 2));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: textColor,
        ),
        tooltipTheme: TooltipThemeData(
          textStyle: TextStyle(
            color: textColor,
          ),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: secondaryColor,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
        brightness: brightness,
        scaffoldBackgroundColor: secondaryColor,
        accentColor: accentColors.value,
        scrollbarTheme: ScrollbarThemeData(
          scrollbarColor: tertiaryColor,
          scrollbarPressingColor: accentColor,
        ),
      ),
      title: 'Lists',
      initialRoute: DB.collections.isNotEmpty ? ListsRoute.routeName : HomeRoute.routeName,
      routes: {
        HomeRoute.routeName: (context) => ContextMenuOverlay(child: HomeRoute()),
        ListsRoute.routeName: (context) => ContextMenuOverlay(child: ListsRoute()),
        ListRoute.routeName: (context) => ContextMenuOverlay(child: ListRoute()),
      },
    );
  }
}

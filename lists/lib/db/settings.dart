import 'dart:convert';
import 'dart:io';

import 'package:lists/db/db.dart';
import 'package:lists/helpers/system_theme.dart';
import 'package:nekolib_ui/core.dart';

class Settings {
  static Future<File> get settingsFile async {
    var dir = await DB.appDir;
    return File('${dir.path}/settings.json');
  }

  static const systemTheme = "System";
  static String _theme = systemTheme;
  static bool _adaptAccent = true;

  static bool get adaptAccent => _adaptAccent && useSystemTheme;
  static bool get useSystemTheme => _theme == systemTheme;
  static String get theme => _theme;

  static void setAdaptAccent(bool value) {
    if (value == _adaptAccent) return;

    _adaptAccent = value;

    NcThemes.setTheme(NcThemes.current, force: true);

    save();
  }

  static void setTheme(String theme) {
    if (theme == _theme) return;
    _theme = theme;

    save();

    if (useSystemTheme) {
      SystemThemeObserver.adaptSystemTheme(force: true);
      return;
    }

    NcThemes.setTheme(NcThemes.all[theme]!);
  }

  static Future save() async {
    var f = await settingsFile;

    var data = {
      "theme": _theme,
      "adaptAccent": _adaptAccent,
    };

    await f.writeAsString(jsonEncode(data));
  }

  static Future load() async {
    var f = await settingsFile;

    if (!f.existsSync()) return;

    var data = jsonDecode(await f.readAsString());

    _theme = data["theme"];
    _adaptAccent = data["adaptAccent"];
  }
}

import 'dart:convert';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent_ui/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:lists/models/db.dart';
import 'package:lists/helpers/system_theme.dart';
import 'package:nekolib_ui/core.dart';

/// Manages the users settings
class Settings {
  /// The name of the system theme.
  static const systemTheme = "System";
  static String _theme = systemTheme;
  static Locale _language = Locale("en");
  static bool _adaptAccent = true;
  static bool _sync = false;

  /// Whether the app should use the system accent.
  static bool get adaptAccent => _adaptAccent && useSystemTheme;

  /// Whether the app should use the system theme.
  static bool get useSystemTheme => _theme == systemTheme;

  /// The current theme.
  static String get theme => _theme;

  /// Whether the app should sync with the cloud.
  static bool get sync => _sync;

  /// The current language.
  static Locale get language => _language;

  /// Sets the value of [adaptAccent]
  static void setAdaptAccent(bool value) {
    if (!useSystemTheme) return;
    if (value == _adaptAccent) return;

    _adaptAccent = value;

    NcThemes.setTheme(NcThemes.current, force: true);

    save();
  }

  /// Sets the value of [language]
  static void setLanguage(Locale value, [bool force = false]) {
    if (value == _language) return;

    _language = value;
    S.load(value);
    Intl.defaultLocale = value.toString();

    save();
  }

  /// Sets the value of [theme].
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

  /// Sets the value of [sync]
  static void setSync(bool value) {
    if (value == _sync) return;
    _sync = value;
    save();
  }

  /// Saves the settings to the disk.
  static Future save() async {
    var f = await DB.settingsFile;

    var data = {
      "theme": _theme,
      "adaptAccent": _adaptAccent,
      "sync": _sync,
      "language": _language.toString(),
    };

    await f.writeAsString(jsonEncode(data));
  }

  /// Loads the settings from disk.
  static Future load() async {
    var f = await DB.settingsFile;

    if (!f.existsSync()) return;

    var data = jsonDecode(await f.readAsString());

    setTheme(data["theme"]);
    _adaptAccent = data["adaptAccent"];
    _sync = data["sync"];

    setLanguage(Locale(data["language"]), true);
  }
}

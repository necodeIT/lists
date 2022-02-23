import 'dart:async';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/db/settings.dart';
import 'package:nekolib_ui/core.dart';
import 'package:system_theme/system_theme.dart';

class SystemThemeObserver {
  static bool _lastValue = false;
  static bool _started = false;
  static AccentColor accentColor = Colors.blue;

  static Future adaptSystemTheme({bool force = false}) async {
    if (!Settings.useSystemTheme) return;
    var darkMode = await SystemTheme.darkMode;

    if (Settings.adaptAccent) await SystemTheme.accentInstance.load();

    var accent = SystemTheme.accentInstance.accent.toAccentColor();

    if (force || (darkMode != _lastValue || accent != accentColor && Settings.adaptAccent)) {
      _lastValue = darkMode;

      accentColor = accent;

      NcThemes.setTheme(darkMode ? darkTheme : lightTheme, force: true);
    }
  }

  static void start() {
    if (_started) return;
    _started = true;

    adaptSystemTheme(force: true);

    Timer.periodic(Duration(seconds: 1), (timer) => adaptSystemTheme());
  }
}

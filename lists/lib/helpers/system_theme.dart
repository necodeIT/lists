import 'dart:async';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/db/settings.dart';
import 'package:nekolib_ui/core.dart';
import 'package:system_theme/system_theme.dart';

class SystemThemeObserver {
  static bool _lastValue = false;
  static bool _started = false;
  static AccentColor _accentColor = Colors.blue;

  static AccentColor get accentColor => _accentColor;

  static Future adaptSystemTheme({bool force = false}) async {
    if (!Settings.useSystemTheme) return;
    var darkMode = await SystemTheme.darkMode;

    // TODO: if (Settings.adaptAccent) await SystemTheme.accentInstance.load();

    // TODO: var accent = SystemTheme.accentInstance.accent.toAccentColor();
    var accent = _accentColor;
    if (force || (darkMode != _lastValue || accent != _accentColor && Settings.adaptAccent)) {
      _lastValue = darkMode;

      _accentColor = accent;

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

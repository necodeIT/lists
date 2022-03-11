import 'dart:async';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/models/settings.dart';
import 'package:nekolib_ui/core.dart';
import 'package:system_theme/system_theme.dart';

class SystemThemeObserver {
  static bool _lastValue = false;
  static bool _started = false;
  static AccentColor _accentColor = Colors.blue;

  static AccentColor get accentColor => _accentColor;

  static bool _error = false;

  static bool get error => _error && Settings.adaptAccent;

  static DateTime _lastError = DateTime.now().subtract(Duration(seconds: 1));
  static Duration _errorCooldown = Duration(seconds: 1);

  static Future adaptSystemTheme({bool force = false}) async {
    if (!Settings.useSystemTheme) return;
    var darkMode = await SystemTheme.darkMode;

    var accent = Colors.blue;

    var error = _lastError.add(_errorCooldown).isAfter(DateTime.now());
    if (Settings.adaptAccent && !error) {
      try {
        await SystemTheme.accentInstance.load();

        accent = SystemTheme.accentInstance.accent.toAccentColor();
      } on Exception {
        _lastError = DateTime.now();
        _errorCooldown = Duration(seconds: _errorCooldown.inSeconds * 2);

        error = true;
      }
    }

    if (force || (darkMode != _lastValue || accent != _accentColor && Settings.adaptAccent) || _error != error) {
      _lastValue = darkMode;

      _accentColor = accent;

      _error = error;

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

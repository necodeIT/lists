import 'dart:async';

import 'package:nekolib_ui/core.dart';
import 'package:rxdart/subjects.dart';
import 'package:system_theme/system_theme.dart';

class SystemThemeObserver {
  static bool _lastValue = false;
  static bool _started = false;

  static Future adaptSystemTheme({bool force = false}) async {
    var darkMode = await SystemTheme.darkMode;

    if (force || darkMode != _lastValue) {
      _lastValue = darkMode;
      NcThemes.setTheme(darkMode ? darkTheme : lightTheme);
    }
  }

  static void start() {
    if (_started) return;
    _started = true;

    adaptSystemTheme(force: true);

    Timer.periodic(Duration(seconds: 1), (timer) => adaptSystemTheme());
  }
}

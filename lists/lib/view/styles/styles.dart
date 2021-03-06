library styles;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/models/settings.dart';
import 'package:lists/helpers/system_theme.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_ui/utils.dart';

part 'buttons.dart';
part 'dialogs.dart';
part 'colors.dart';
part 'text_box.dart';
part 'toggle_switch.dart';
part 'tooltip.dart';
part 'scrollbar.dart';
part 'checkbox.dart';
part 'infobar.dart';

/// Default styles for the app.
ThemeData theme() => ThemeData(
      uncheckedColor: primaryColor,
      dialogTheme: contentDialogStyle(),
      iconTheme: IconThemeData(color: textColor),
      backgroundInputColor: primaryColor,
      menuColor: tertiaryColor,
      cardColor: surfaceColor,
      borderInputColor: tertiaryColor,
      micaBackgroundColor: primaryColor,
      acrylicBackgroundColor: primaryColor,
      toggleSwitchTheme: toggleSwitchThemeData(),
      tooltipTheme: tooltipThemeData(),
      buttonTheme: buttonThemeData(),
      brightness: brightness,
      scaffoldBackgroundColor: secondaryColor,
      accentColor: adaptiveAccentColor,
      scrollbarTheme: scrollbarThemeData(),
      inactiveBackgroundColor: primaryColor,
      inactiveColor: tertiaryColor,
      checkboxTheme: checkboxThemeData(),
      infoBarTheme: infoBarThemeData(),
    );

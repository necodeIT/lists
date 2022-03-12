library list_styles;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/models/settings.dart';
import 'package:lists/helpers/system_theme.dart';
import 'package:nekolib_ui/core.dart';
import 'package:system_theme/system_theme.dart';

part 'buttons.dart';
part 'dialogs.dart';
part 'accent_colors.dart';
part 'text_box.dart';
part 'toggle_switch.dart';
part 'tooltip.dart';
part 'scrollbar.dart';

ThemeData theme() => ThemeData(
      dialogTheme: contentDialogStyle(),
      iconTheme: IconThemeData(color: textColor),
      menuColor: tertiaryColor,
      cardColor: primaryColor,
      borderInputColor: textColor,
      micaBackgroundColor: primaryColor,
      acrylicBackgroundColor: primaryColor,
      toggleSwitchTheme: toggleSwitchThemeData(),
      tooltipTheme: tooltipThemeData(),
      buttonTheme: buttonThemeData(),
      brightness: brightness,
      scaffoldBackgroundColor: secondaryColor,
      accentColor: adaptiveAccentColor,
      scrollbarTheme: scrollbarThemeData(),
    );

part of styles;

/// Themed theme data for [InfoBar].
InfoBarThemeData infoBarThemeData() => InfoBarThemeData(
      iconColor: (severity) {
        switch (severity) {
          case InfoBarSeverity.error:
            return errorColor;
          case InfoBarSeverity.warning:
            return warningColor;
          case InfoBarSeverity.info:
            return adaptiveAccentColor;
          case InfoBarSeverity.success:
            return successColor;
        }
      },
      decoration: (severity) {
        late final Color color;

        switch (severity) {
          case InfoBarSeverity.error:
            color = errorColor;
            break;
          case InfoBarSeverity.warning:
            color = warningColor;
            break;
          case InfoBarSeverity.info:
            color = adaptiveAccentColor;
            break;
          case InfoBarSeverity.success:
            color = successColor;
            break;
        }

        return BoxDecoration(
          color: _backgroundColorModifier.value(color),
          border: Border.all(color: _backgroundColorModifier.value(color)),
          borderRadius: BorderRadius.circular(4),
        );
      },
    );

final ThemeableProperty<Function(Color)> _backgroundColorModifier = ThemeableProperty<Function(Color)>.only(
  (color) => color.withOpacity(.1),
  {
    lightTheme: (color) => color.lighten(.375),
  },
);

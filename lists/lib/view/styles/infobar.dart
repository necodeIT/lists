part of styles;

/// Themed theme data for [InfoBar].
InfoBarThemeData infoBarThemeData() => InfoBarThemeData(
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
          color: brightness.isLight ? color.lighten(.375) : color.withOpacity(.5),
          border: Border.all(color: brightness.isLight ? color.lighten(.375) : color.withOpacity(.5)),
          borderRadius: BorderRadius.circular(4),
        );
      },
    );

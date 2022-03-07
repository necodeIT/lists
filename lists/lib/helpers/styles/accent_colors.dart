part of list_styles;

AccentColor get adaptiveAccentColor => Settings.adaptAccent && !SystemThemeObserver.error ? SystemThemeObserver.accentColor : _accentColors.value;
// AccentColor get adaptiveAccentColor => _accentColors.value;

ThemeableProperty _accentColors = ThemeableProperty<AccentColor>(
  {
    sakuraTheme: AccentColor(
      "normal",
      const <String, Color>{
        'darkest': Color(0xffaa726f),
        'darker': Color(0xffc2827e),
        'dark': Color(0xffdb938e),
        'normal': Color(0xFFF3A39E),
        'light': Color(0xfff4aca8),
        'lighter': Color(0xfff5b5b1),
        'lightest': Color(0xfff7bfbb),
      },
    ),
    oceanTheme: AccentColor(
      "normal",
      const <String, Color>{
        'darkest': Color(0xff5473b2),
        'darker': Color(0xff6084cb),
        'dark': Color(0xff6c95e5),
        'normal': Color(0xFF78A5FE),
        'light': Color(0xff86aefe),
        'lighter': Color(0xff93b7fe),
        'lightest': Color(0xffa1c0fe),
      },
    ),
    darkTheme: AccentColor(
      "normal",
      const <String, Color>{
        'darkest': Color(0xff1b84aa),
        'darker': Color(0xff1f96c2),
        'dark': Color(0xff23a9db),
        'normal': Color(0xFF27BCF3),
        'light': Color(0xff3dc3f4),
        'lighter': Color(0xff52c9f5),
        'lightest': Color(0xff68d0f7),
      },
    ),
    lightTheme: AccentColor(
      "normal",
      const <String, Color>{
        'darkest': Color(0xff1b84aa),
        'darker': Color(0xff1f96c2),
        'dark': Color(0xff23a9db),
        'normal': Color(0xFF27BCF3),
        'light': Color(0xff3dc3f4),
        'lighter': Color(0xff52c9f5),
        'lightest': Color(0xff68d0f7),
      },
    ),
  },
);

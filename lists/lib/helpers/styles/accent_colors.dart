part of list_styles;

ThemeableProperty accentColors = ThemeableProperty<AccentColor>(
  {
    sakuraTheme: Colors.blue,
    oceanTheme: Colors.blue,
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
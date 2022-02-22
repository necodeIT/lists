part of list_styles;

ButtonStyle filledButtonStyle() => ButtonStyle(
      padding: ButtonState.all(EdgeInsets.all(8.0)),
      backgroundColor: ButtonState.all(accentColor),
      border: ButtonState.all(
        BorderSide(color: accentColor),
      ),
      elevation: ButtonState.all(1.5),
    );

// var _buttonStyleColors = ThemeableProperty<Color>.only(Colors.transparent, {
//   lightTheme: lightTheme.primaryColor,
//   darkTheme: darkTheme.tertiaryColor,
// });

ButtonStyle buttonStyle() => ButtonStyle(
      padding: ButtonState.all(EdgeInsets.all(8.0)),
      backgroundColor: ButtonState.all(secondaryColor),
      border: ButtonState.all(
        BorderSide(color: secondaryColor),
      ),
      elevation: ButtonState.all(1.5),
    );

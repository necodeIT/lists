part of list_styles;

buttonThemeData() => ButtonThemeData(
      defaultButtonStyle: buttonStyle(),
      filledButtonStyle: filledButtonStyle(),
    );

ButtonStyle filledButtonStyle() => ButtonStyle(
      padding: ButtonState.all(EdgeInsets.all(8.0)),
      backgroundColor: ButtonState.all(adaptiveAccentColor),
      border: ButtonState.all(
        BorderSide(color: adaptiveAccentColor),
      ),
      elevation: ButtonState.all(1.5),
    );

// var _buttonStyleColors = ThemeableProperty<Color>.only(Colors.transparent, {
//   lightTheme: lightTheme.primaryColor,
//   darkTheme: darkTheme.tertiaryColor,
// });

ButtonStyle buttonStyle([Color? color, double? elevation, BorderStyle? borderStyle]) => ButtonStyle(
      padding: ButtonState.all(EdgeInsets.all(8.0)),
      backgroundColor: ButtonState.all(color ?? secondaryColor),
      border: ButtonState.all(
        BorderSide(color: color ?? secondaryColor, style: borderStyle ?? BorderStyle.solid),
      ),
      foregroundColor: ButtonState.all(textColor),
      elevation: ButtonState.all(elevation ?? 1.5),
    );

BoxDecoration dropDownButtonMenuStyle() => BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: primaryColor,
      border: Border.all(color: secondaryColor, width: 1.5),
    );

Color expanderContentBackground() => tertiaryColor.withOpacity(.5);
ButtonState<Color> expanderHeaderBackground() => ButtonState.all(secondaryColor);

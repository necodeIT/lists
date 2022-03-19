part of list_styles;

buttonThemeData() => ButtonThemeData(
      defaultButtonStyle: buttonStyle(color: primaryColor, hoverColor: secondaryColor),
      filledButtonStyle: filledButtonStyle(),
    );

ButtonStyle filledButtonStyle() => ButtonStyle(
      padding: ButtonState.all(EdgeInsets.all(8.0)),
      backgroundColor: ButtonState.resolveWith((states) => states.isHovering ? adaptiveAccentColor.light : adaptiveAccentColor),
      border: ButtonState.resolveWith(
        (states) => BorderSide(color: states.isHovering ? adaptiveAccentColor.light : adaptiveAccentColor),
      ),
      elevation: ButtonState.all(1.5),
    );

ButtonStyle buttonStyle({Color? color, Color? hoverColor, double? elevation, BorderStyle? borderStyle}) => ButtonStyle(
      padding: ButtonState.all(EdgeInsets.all(8.0)),
      backgroundColor: ButtonState.resolveWith(
        (states) {
          if (states.isHovering) {
            return hoverColor ?? primaryColor.withOpacity(0.7);
          }

          return color ?? primaryColor;
        },
      ),
      border: ButtonState.resolveWith((states) {
        var defaultColor = color ?? primaryColor;
        var hover = hoverColor ?? primaryColor.withOpacity(0.7);
        return BorderSide(color: states.isHovering ? hover : defaultColor, style: borderStyle ?? BorderStyle.solid);
      }),
      foregroundColor: ButtonState.all(textColor),
      elevation: ButtonState.all(elevation ?? 1.5),
    );

BoxDecoration dropDownButtonMenuStyle() => BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: primaryColor,
      border: Border.all(color: secondaryColor, width: 1.5),
    );

Color expanderContentBackground() => tertiaryColor.withOpacity(.5);
ButtonState<Color> expanderHeaderBackground() => ButtonState.all(primaryColor);

ButtonStyle iconButtonStyle() => ButtonStyle(
      iconSize: ButtonState.all(11.0),
      padding: ButtonState.all(const EdgeInsets.all(8)),
      backgroundColor: ButtonState.resolveWith(
        (states) {
          if (states.isPressing) {
            return tertiaryColor.withOpacity(.6);
          } else if (states.isHovering) {
            return tertiaryColor.withOpacity(.4);
          } else {
            return Colors.transparent;
          }
        },
      ),
      foregroundColor: ButtonState.resolveWith((states) {
        if (states.isDisabled) return tertiaryColor;
        return null;
      }),
      shape: ButtonState.resolveWith(
        (state) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(color: state.isNone ? Colors.transparent : tertiaryColor),
        ),
      ),
    );

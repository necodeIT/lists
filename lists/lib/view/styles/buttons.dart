part of styles;

/// Button styles.
buttonThemeData() => ButtonThemeData(
      defaultButtonStyle: buttonStyle(color: primaryColor),
      filledButtonStyle: filledButtonStyle(),
    );

/// The value to darken buttons by on hover.
double get kDarkenValue => brightness.isLight ? 0.05 : 0.01;

/// Default style for a [FilledButton].
ButtonStyle filledButtonStyle() => ButtonStyle(
      padding: ButtonState.all(EdgeInsets.all(8.0)),
      backgroundColor: ButtonState.resolveWith((states) => states.isHovering ? adaptiveAccentColor.dark : adaptiveAccentColor),
      border: ButtonState.resolveWith(
        (states) => BorderSide(color: states.isHovering ? adaptiveAccentColor.dark : adaptiveAccentColor),
      ),
      elevation: ButtonState.all(1.5),
    );

/// Default style for a [Button].
ButtonStyle buttonStyle({Color? color, Color? hoverColor, double? elevation, BorderStyle? borderStyle}) => ButtonStyle(
      padding: ButtonState.all(EdgeInsets.all(8.0)),
      backgroundColor: ButtonState.resolveWith(
        (states) {
          if (states.isHovering) {
            return hoverColor ?? primaryColor.darken(kDarkenValue);
          }

          return color ?? primaryColor;
        },
      ),
      border: ButtonState.resolveWith((states) {
        var borderColor = states.isHovering ? hoverColor ?? primaryColor.darken(kDarkenValue) : color ?? primaryColor;
        return BorderSide(color: borderColor, style: borderStyle ?? BorderStyle.solid);
      }),
      foregroundColor: ButtonState.all(textColor),
      elevation: ButtonState.all(elevation ?? 1.5),
    );

/// Default style for a [DropDownButton].
BoxDecoration dropDownButtonMenuStyle() => BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: primaryColor,
      border: Border.all(color: secondaryColor, width: 1.5),
    );

/// Default background color for [Expander] content.
Color expanderContentBackground() => tertiaryColor.withOpacity(.5);

/// Default background color for [Expander] header.
ButtonState<Color> expanderHeaderBackground() => ButtonState.all(primaryColor);

/// Default [IconButton] style
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

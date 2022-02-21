part of list_styles;

ButtonStyle filledButtonStyle() => ButtonStyle(
      padding: ButtonState.all(EdgeInsets.all(8.0)),
      backgroundColor: ButtonState.all(accentColor),
      border: ButtonState.all(
        BorderSide(color: accentColor),
      ),
      elevation: ButtonState.all(1.5),
    );

ButtonStyle buttonStyle() => ButtonStyle(
      padding: ButtonState.all(EdgeInsets.all(8.0)),
      backgroundColor: ButtonState.all(primaryColor),
      border: ButtonState.all(
        BorderSide(color: secondaryColor),
      ),
      elevation: ButtonState.all(1.5),
    );

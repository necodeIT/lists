part of styles;

toggleSwitchThemeData() => ToggleSwitchThemeData(
      checkedThumbDecoration: ButtonState.all(
        BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      uncheckedDecoration: ButtonState.all(
        BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: textColor),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      uncheckedThumbDecoration: ButtonState.all(
        BoxDecoration(
          color: textColor,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );

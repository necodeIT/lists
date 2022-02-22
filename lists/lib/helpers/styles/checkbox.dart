part of list_styles;

checkBoxStyle() => CheckboxThemeData(
      checkedDecoration: ButtonState.all(
        BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      uncheckedDecoration: ButtonState.all(
        BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: tertiaryColor,
            width: 1.4,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );

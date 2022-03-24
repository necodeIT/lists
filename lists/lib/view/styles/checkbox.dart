part of styles;

CheckboxThemeData checkboxThemeData() => CheckboxThemeData(
      icon: FluentIcons.ic_fluent_checkmark_24_filled,
      checkedIconColor: ButtonState.all(buttonTextColor),
      // checkedDecoration: ButtonState.resolveWith(
      //   (states) => BoxDecoration(
      //     borderRadius: radius,
      //     color: !states.isDisabled
      //         ? ButtonThemeData.checkedInputColor(style, states)
      //         : style.brightness.isLight
      //             ? const Color.fromRGBO(0, 0, 0, 0.2169)
      //             : const Color.fromRGBO(255, 255, 255, 0.1581),
      //   ),
      // ),
    );

part of styles;

tooltipThemeData() => TooltipThemeData(
      textStyle: TextStyle(
        color: textColor,
      ),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: secondaryColor,
        ),
        boxShadow: kElevationToShadow[1],
      ),
    );

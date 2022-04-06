part of styles;

/// Default [ContentDialog] style.
contentDialogStyle() => ContentDialogThemeData(
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tertiaryColor, width: 1),
        boxShadow: kElevationToShadow[2],
      ),
      actionsDecoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );

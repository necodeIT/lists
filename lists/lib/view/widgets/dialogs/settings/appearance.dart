part of 'settings_dialog.dart';

class AppearanceOptions extends StatefulWidget {
  const AppearanceOptions({
    Key? key,
  }) : super(key: key);

  @override
  State<AppearanceOptions> createState() => _AppearanceOptionsState();
}

class _AppearanceOptionsState extends State<AppearanceOptions> {
  _setTheme(String? theme) {
    if (theme == null) return;
    setState(() {
      Settings.setTheme(theme);
    });
  }

  _setAdaptAccent(bool? value) {
    setState(() {
      Settings.setAdaptAccent(value ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expander(
      contentPadding: 0,
      headerBackgroundColor: expanderHeaderBackground(),
      contentBackgroundColor: expanderContentBackground(),
      header: ExpanderHeader(icon: FluentIcons.ic_fluent_color_24_regular, text: "Appearance"),
      content: Column(
        children: [
          SettingsContainer(
            title: NcTitleText("Select theme"),
            trailing: FluentTheme(
              data: ThemeData(
                brightness: brightness,
                accentColor: adaptiveAccentColor,
                uncheckedColor: accentColor,
                buttonTheme: ButtonThemeData(
                  defaultButtonStyle: buttonStyle(primaryColor),
                ),
                menuColor: primaryColor,
              ),
              // child: DropDownButton(
              //   menuDecoration: dropDownButtonMenuStyle(),
              //   title: NcCaptionText(Settings.theme),
              //   items: [
              //     for (var theme in NcThemes.all.keys)
              //       DropDownButtonItem(
              //         onTap: () => _setTheme(theme),
              //         title: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             FluentVertivalDvider(color: Settings.theme == theme ? adaptiveAccentColor : Colors.transparent),
              //             NcSpacing.xs(),
              //             NcCaptionText(theme),
              //           ],
              //         ),
              //       ),
              //     DropDownButtonItem(
              //       onTap: () => _setTheme(Settings.systemTheme),
              //       title: Row(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           FluentVertivalDvider(color: Settings.useSystemTheme ? adaptiveAccentColor : Colors.transparent),
              //           NcSpacing.xs(),
              //           NcCaptionText(Settings.systemTheme),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),

              child: Combobox<String>(
                // icon: Icon(FluentIcons.ic_fluent_chevron_down_24_filled),

                value: Settings.theme,
                onChanged: _setTheme,
                items: [
                  for (var theme in NcThemes.all.keys)
                    ComboboxItem(
                      child: NcCaptionText(theme),
                      value: theme,
                    ),
                  ComboboxItem(
                    child: NcCaptionText(Settings.systemTheme),
                    value: Settings.systemTheme,
                  ),
                ],
              ),
            ),
          ),
          SettingsContainer(
            icon: Settings.useSystemTheme ? null : FluentIcons.ic_fluent_error_circle_24_regular,
            iconTooltip: "Adaptive accent is only available when using system theme",
            onTap: Settings.useSystemTheme ? () => _setAdaptAccent(!Settings.adaptAccent) : null,
            title: NcTitleText("Adaptive accent (unstable)"),
            trailing: Checkbox(
              checked: Settings.adaptAccent,
              onChanged: Settings.useSystemTheme ? _setAdaptAccent : null,
            ),
          ),
          if (SystemThemeObserver.error)
            SettingsContainer(
              color: errorColor.withOpacity(.3),
              title: NcCaptionText("Error reading system accent color! Using default."),
              trailing: TooltipIconButton(
                icon: FluentIcons.ic_fluent_more_horizontal_24_filled,
                tooltip: "Details...",
                onPressed: () => showAlertDialog(
                  context,
                  "Accent Color Error",
                  "This error randomly occurs when the system accent color is not readable by the app.\n\nI don't know why this happens but the default accent color of the currently active theme is used instead.\n\nIf you know why this happens, please report it on the GitHub repo and/or submit a pull request.\n\nPS: Please help me it's driving me crazy!",
                ),
              ),
              icon: FluentIcons.ic_fluent_error_circle_24_regular,
            ),
        ],
      ),
    );
  }
}

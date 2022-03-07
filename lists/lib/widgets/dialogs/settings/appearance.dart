part of 'settings_dialog.dart';

class AppearanceOptions extends StatefulWidget {
  const AppearanceOptions({
    Key? key,
  }) : super(key: key);

  @override
  State<AppearanceOptions> createState() => _AppearanceOptionsState();
}

class _AppearanceOptionsState extends State<AppearanceOptions> {
  _setTheme(String theme) {
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
      initiallyExpanded: true,
      headerBackgroundColor: expanderHeaderBackground(),
      contentBackgroundColor: expanderContentBackground(),
      header: ExpanderHeader(icon: FluentIcons.ic_fluent_color_24_regular, text: "Appearance"),
      content: Column(
        children: [
          InfoBoxContainer(
            padding: expanderInfoBoxContainerPadding(),
            margin: expanderInfoBoxContainerMargin(),
            height: expanderInfoBoxContainerHeight(),
            backgroundColor: expanderInfoBoxContainerBackroundColor(),
            shadow: false,
            borderColor: Colors.transparent,
            title: NcTitleText("Select theme"),
            trailing: FluentTheme(
              data: ThemeData(
                buttonTheme: ButtonThemeData(
                  defaultButtonStyle: buttonStyle(tertiaryColor.withOpacity(.2), 0, BorderStyle.none),
                ),
              ),
              child: DropDownButton(
                menuDecoration: dropDownButtonMenuStyle(),
                title: NcCaptionText(Settings.theme),
                items: [
                  for (var theme in NcThemes.all.keys)
                    DropDownButtonItem(
                      onTap: () => _setTheme(theme),
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FluentVertivalDvider(color: Settings.theme == theme ? adaptiveAccentColor : Colors.transparent),
                          NcSpacing.xs(),
                          NcCaptionText(theme),
                        ],
                      ),
                    ),
                  DropDownButtonItem(
                    onTap: () => _setTheme(Settings.systemTheme),
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FluentVertivalDvider(color: Settings.useSystemTheme ? adaptiveAccentColor : Colors.transparent),
                        NcSpacing.xs(),
                        NcCaptionText(Settings.systemTheme),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          InfoBoxContainer(
            padding: expanderInfoBoxContainerPadding(),
            height: expanderInfoBoxContainerHeight(),
            backgroundColor: expanderInfoBoxContainerBackroundColor(),
            margin: expanderInfoBoxContainerMargin(),
            shadow: false,
            borderColor: Colors.transparent,
            icon: Settings.useSystemTheme ? null : FluentIcons.ic_fluent_error_circle_24_regular,
            iconToolTip: "Adaptive accent is only available when using system theme",
            title: GestureDetector(
              child: NcTitleText("Adaptive accent (unstable)"),
              onTap: Settings.useSystemTheme ? () => _setAdaptAccent(!Settings.adaptAccent) : null,
            ),
            trailing: Checkbox(
              checked: Settings.adaptAccent,
              onChanged: Settings.useSystemTheme ? _setAdaptAccent : null,
            ),
          ),
          if (SystemThemeObserver.error)
            InfoBoxContainer(
              padding: expanderInfoBoxContainerPadding(),
              height: expanderInfoBoxContainerHeight(),
              backgroundColor: errorColor.withOpacity(.3),
              margin: expanderInfoBoxContainerMargin(),
              shadow: false,
              borderColor: errorColor.withOpacity(.3),
              title: NcCaptionText("Error reading system accent color! Using default."),
              icon: FluentIcons.ic_fluent_error_circle_24_regular,
            ),
        ],
      ),
    );
  }
}

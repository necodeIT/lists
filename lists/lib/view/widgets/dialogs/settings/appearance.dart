part of 'settings_dialog.dart';

/// Appearance settings.
class AppearanceOptions extends StatefulWidget {
  /// Appearance settings.
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
      header: ExpanderHeader(icon: FluentIcons.ic_fluent_color_24_regular, text: S.of(context).appearance),
      content: Column(
        children: [
          SettingsContainer(
            title: NcTitleText(S.of(context).selectTheme),
            trailing: FluentTheme(
              data: ThemeData(
                brightness: brightness,
                accentColor: adaptiveAccentColor,
                buttonTheme: ButtonThemeData(
                  defaultButtonStyle: buttonStyle(color: Colors.transparent, hoverColor: secondaryColor),
                ),
                menuColor: primaryColor,
              ),
              child: Combobox<String>(
                iconSize: 16,
                icon: Icon(
                  FluentIcons.ic_fluent_chevron_down_24_filled,
                  color: textColor,
                ),
                value: Settings.theme,
                onChanged: _setTheme,
                items: [
                  for (var theme in NcThemes.all.keys)
                    ComboboxItem(
                      child: NcCaptionText(theme),
                      value: theme,
                    ),
                  ComboboxItem(
                    child: SizedBox(width: 60, child: NcCaptionText(Settings.systemTheme)),
                    value: Settings.systemTheme,
                  ),
                ],
              ),
            ),
          ),
          SettingsContainer(
            icon: Settings.useSystemTheme ? null : FluentIcons.ic_fluent_error_circle_24_regular,
            iconTooltip: S.of(context).adaptiveAccentIsOnlyAvailableWhenUsingSystemTheme,
            onTap: Settings.useSystemTheme ? () => _setAdaptAccent(!Settings.adaptAccent) : null,
            title: NcTitleText(S.of(context).adaptiveAccentUnstable),
            trailing: Checkbox(
              checked: Settings.adaptAccent,
              onChanged: Settings.useSystemTheme ? _setAdaptAccent : null,
            ),
          ),
          if (SystemThemeObserver.error)
            InfoBar(
              severity: InfoBarSeverity.error,
              title: NcCaptionText(S.of(context).errorReadingSystemAccentColor),
              content: NcBodyText(
                S.of(context).errorReadingSystemAccentColorDescription,
                overflow: TextOverflow.visible,
              ),
              isLong: true,
            ),
        ],
      ),
    );
  }
}

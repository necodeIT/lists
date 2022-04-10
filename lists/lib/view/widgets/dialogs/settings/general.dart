part of "settings_dialog.dart";

/// General settings.
class GeneralOptions extends StatefulWidget {
  /// General settings.
  const GeneralOptions({Key? key}) : super(key: key);

  @override
  State<GeneralOptions> createState() => _GeneralOptionsState();
}

class _GeneralOptionsState extends State<GeneralOptions> {
  bool _checkedUpdates = false;

  _checkUpdates() {
    setState(() {
      _checkedUpdates = true;
    });
  }

  _showErrorDetails(String error) {
    showAlertDialog(context, t.error, error);
  }

  @override
  Widget build(BuildContext context) {
    return Expander(
      contentPadding: 0,
      headerBackgroundColor: expanderHeaderBackground(),
      contentBackgroundColor: expanderContentBackground(),
      header: ExpanderHeader(icon: FluentIcons.ic_fluent_settings_24_regular, text: t.general),
      content: Column(
        children: [
          Consumer(builder: (context, ref, child) {
            var locale = ref.watch(localeProvider);

            return FluentTheme(
              data: ThemeData(
                brightness: brightness,
                accentColor: adaptiveAccentColor,
                buttonTheme: ButtonThemeData(
                  defaultButtonStyle: buttonStyle(color: Colors.transparent, hoverColor: secondaryColor),
                ),
                menuColor: primaryColor,
              ),
              child: SettingsContainer(
                title: NcTitleText(t.language),
                icon: FluentIcons.ic_fluent_local_language_24_filled,
                trailing: Combobox<Locale>(
                  value: locale.locale,
                  onChanged: locale.load,
                  items: [
                    for (var language in AppLocalizations.supportedLocales)
                      ComboboxItem(
                        value: language,
                        child: SizedBox(
                          width: 60,
                          child: NcBodyText(LocaleNamesLocalizationsDelegate.nativeLocaleNames[language.languageCode] ?? ""),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
          SettingsContainer(
            icon: FluentIcons.ic_fluent_number_symbol_24_filled,
            title: NcTitleText(t.version),
            trailing: NcBodyText(Updater.versionName),
          ),
          SettingsContainer(
            icon: FluentIcons.ic_fluent_arrow_clockwise_24_filled,
            title: NcTitleText(t.checkForUpdates),
            onTap: _checkUpdates,
            trailing: SettingsIcon(icon: FluentIcons.ic_fluent_chevron_right_24_filled),
          ),
          if (_checkedUpdates)
            FutureBuilder<bool>(
              future: Updater.update(),
              builder: (context, snapshot) {
                var error = Updater.getErrorMessage();
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return InfoBar(
                    title: NcTitleText(t.checkingForUpdates),
                    action: SizedBox(
                      width: 15,
                      height: 15,
                      child: ProgressRing(
                        activeColor: adaptiveAccentColor,
                        strokeWidth: 3,
                      ),
                    ),
                  );
                } else if (error == null) {
                  return !Updater.updateAvailable
                      ? InfoBar(
                          title: NcTitleText(t.youAreOnTheLatestVersion),
                          severity: InfoBarSeverity.success,
                        )
                      : InfoBar(
                          title: NcTitleText(t.updateAvailable),
                          action: TooltipIconButton(
                            tooltip: t.updateAvailableUpdate,
                            icon: FluentIcons.ic_fluent_arrow_download_24_filled,
                            onPressed: () => Navigator.of(context).pushNamed(UpgradeRoute.routeName, arguments: true),
                          ),
                        );
                } else {
                  return InfoBar(
                    title: NcTitleText(t.errorCheckingForUpdates),
                    content: NcBodyText(t.errorCheckingForUpdatesDescription),
                    action: TooltipIconButton.small(
                      icon: FluentIcons.ic_fluent_more_horizontal_24_filled,
                      tooltip: t.showDetails,
                      onPressed: () => _showErrorDetails(error),
                    ),
                    severity: InfoBarSeverity.error,
                  );
                }
              },
            ),
        ],
      ),
    );
  }
}

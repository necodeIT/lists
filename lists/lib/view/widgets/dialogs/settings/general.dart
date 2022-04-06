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
    showAlertDialog(context, "Error", error);
  }

  @override
  Widget build(BuildContext context) {
    return Expander(
      contentPadding: 0,
      headerBackgroundColor: expanderHeaderBackground(),
      contentBackgroundColor: expanderContentBackground(),
      header: ExpanderHeader(icon: FluentIcons.ic_fluent_settings_24_regular, text: "General"),
      content: Column(
        children: [
          SettingsContainer(
            icon: FluentIcons.ic_fluent_number_symbol_24_filled,
            title: NcTitleText("Version"),
            trailing: NcBodyText(Updater.versionName),
          ),
          SettingsContainer(
            icon: FluentIcons.ic_fluent_arrow_clockwise_24_filled,
            title: NcTitleText("Check for updates"),
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
                    title: NcTitleText("Checking for updates..."),
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
                          title: NcTitleText("You are on the latest version!"),
                          severity: InfoBarSeverity.success,
                        )
                      : InfoBar(
                          title: NcTitleText("Update available"),
                          action: TooltipIconButton(
                            tooltip: "Update",
                            icon: FluentIcons.ic_fluent_arrow_download_24_filled,
                            onPressed: () => Navigator.of(context).pushNamed(UpgradeRoute.routeName, arguments: true),
                          ),
                        );
                } else {
                  return InfoBar(
                    title: NcTitleText("Error checking for updates"),
                    content: NcBodyText("Please check your internet connection and try again later."),
                    action: TooltipIconButton.small(
                      icon: FluentIcons.ic_fluent_more_horizontal_24_filled,
                      tooltip: "Show error details",
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

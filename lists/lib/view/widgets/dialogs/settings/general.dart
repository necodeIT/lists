part of "settings_dialog.dart";

class GeneralOptions extends StatefulWidget {
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

  _showErrorDetauls(String error) {
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
                  return SettingsContainer(
                    title: NcTitleText("Checking for updates..."),
                    trailing: SizedBox(
                      width: 15,
                      height: 15,
                      child: ProgressRing(
                        activeColor: adaptiveAccentColor,
                        strokeWidth: 3,
                      ),
                    ),
                  );
                } else if (error.isEmpty) {
                  return !Updater.updateAvailable
                      ? SettingsContainer(
                          icon: FluentIcons.ic_fluent_checkmark_24_filled,
                          color: successColor.withOpacity(.5),
                          title: NcTitleText("You are on the latest version!"),
                        )
                      : SettingsContainer(
                          icon: FluentIcons.ic_fluent_info_24_regular,
                          color: warningColor.withOpacity(.5),
                          title: NcTitleText("Update available"),
                          trailing: TooltipIconButton(
                            tooltip: "Update",
                            icon: FluentIcons.ic_fluent_arrow_download_24_filled,
                            onPressed: () => Navigator.of(context).pushNamed(UpgradeRoute.routeName, arguments: true),
                          ),
                        );
                } else {
                  return SettingsContainer(
                    icon: FluentIcons.ic_fluent_error_circle_24_regular,
                    color: errorColor.withOpacity(.5),
                    title: NcTitleText("Error checking for updates"),
                    trailing: TooltipIconButton(
                      icon: FluentIcons.ic_fluent_more_horizontal_24_filled,
                      tooltip: "Show error details",
                      onPressed: () => _showErrorDetauls(error),
                    ),
                  );
                }
              },
            ),
        ],
      ),
    );
  }
}

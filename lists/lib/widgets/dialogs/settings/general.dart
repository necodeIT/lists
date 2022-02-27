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
      initiallyExpanded: true,
      headerBackgroundColor: expanderHeaderBackground(),
      contentBackgroundColor: expanderContentBackground(),
      header: ExpanderHeader(icon: FluentIcons.ic_fluent_settings_24_regular, text: "General"),
      content: Column(
        children: [
          InfoBoxContainer(
            padding: expanderInfoBoxContainerPadding(),
            margin: expanderInfoBoxContainerMargin(),
            height: expanderInfoBoxContainerHeight(),
            backgroundColor: expanderInfoBoxContainerBackroundColor(),
            icon: FluentIcons.ic_fluent_number_symbol_24_filled,
            shadow: false,
            borderColor: Colors.transparent,
            title: NcTitleText("Version"),
            trailing: NcBodyText(Updater.versionName),
          ),
          InfoBoxContainer(
            padding: expanderInfoBoxContainerPadding(),
            margin: expanderInfoBoxContainerMargin(),
            height: expanderInfoBoxContainerHeight(),
            backgroundColor: expanderInfoBoxContainerBackroundColor(),
            shadow: false,
            icon: FluentIcons.ic_fluent_arrow_clockwise_dashes_24_filled,
            borderColor: Colors.transparent,
            title: NcTitleText("Check for updates"),
            trailing: TooltipIconButton(
              icon: FluentIcons.ic_fluent_arrow_clockwise_24_filled,
              tooltip: "Check for updates",
              onPressed: _checkUpdates,
            ),
          ),
          if (_checkedUpdates)
            FutureBuilder<bool>(
              future: Updater.update(),
              builder: (context, snapshot) {
                var error = Updater.getErrorMessage();
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return InfoBoxContainer(
                    padding: expanderInfoBoxContainerPadding(),
                    margin: expanderInfoBoxContainerMargin(),
                    height: expanderInfoBoxContainerHeight(),
                    backgroundColor: expanderInfoBoxContainerBackroundColor(),
                    shadow: false,
                    borderColor: Colors.transparent,
                    title: NcTitleText("Checking for updates..."),
                    trailing: SizedBox(
                      width: 15,
                      height: 15,
                      child: ProgressRing(
                        strokeWidth: 3,
                      ),
                    ),
                  );
                } else if (error.isEmpty) {
                  return !Updater.updateAvailable
                      ? InfoBoxContainer(
                          padding: expanderInfoBoxContainerPadding(),
                          margin: expanderInfoBoxContainerMargin(),
                          height: expanderInfoBoxContainerHeight(),
                          backgroundColor: successColor.withOpacity(.3),
                          shadow: false,
                          icon: FluentIcons.ic_fluent_checkmark_24_filled,
                          borderColor: successColor.withOpacity(.3),
                          title: NcTitleText("You are on the latest version!"),
                        )
                      : InfoBoxContainer(
                          padding: expanderInfoBoxContainerPadding(),
                          margin: expanderInfoBoxContainerMargin(),
                          height: expanderInfoBoxContainerHeight(),
                          backgroundColor: warningColor.withOpacity(.3),
                          shadow: false,
                          icon: FluentIcons.ic_fluent_info_24_regular,
                          borderColor: warningColor.withOpacity(.3),
                          title: NcTitleText("Update available"),
                          trailing: TooltipIconButton(
                            tooltip: "Update",
                            icon: FluentIcons.ic_fluent_arrow_download_24_filled,
                            onPressed: () => Navigator.of(context).pushNamed(UpgradeRoute.routeName, arguments: true),
                          ),
                        );
                } else {
                  return InfoBoxContainer(
                    padding: expanderInfoBoxContainerPadding(),
                    margin: expanderInfoBoxContainerMargin(),
                    height: expanderInfoBoxContainerHeight(),
                    backgroundColor: errorColor.withOpacity(.3),
                    shadow: false,
                    icon: FluentIcons.ic_fluent_error_circle_24_regular,
                    borderColor: errorColor.withOpacity(.3),
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

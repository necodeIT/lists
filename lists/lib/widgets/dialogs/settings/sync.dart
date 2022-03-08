part of 'settings_dialog.dart';

class SyncOptions extends StatefulWidget {
  const SyncOptions({
    Key? key,
  }) : super(key: key);

  @override
  State<SyncOptions> createState() => _SyncOptionsState();
}

class _SyncOptionsState extends State<SyncOptions> {
  _setSync(bool? value) {
    setState(() {
      Settings.setSync(value ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expander(
      contentPadding: 0,
      headerBackgroundColor: expanderHeaderBackground(),
      contentBackgroundColor: expanderContentBackground(),
      initiallyExpanded: false,
      header: ExpanderHeader(icon: FluentIcons.ic_fluent_arrow_sync_24_filled, text: "Sync"),
      content: Column(
        children: [
          InfoBoxContainer(
            padding: settingsContainerPadding(),
            height: settingsContainerHeight(),
            backgroundColor: settingsContainerBackroundColor(),
            margin: settingsContainerMargin(),
            borderColor: Colors.transparent,
            shadow: false,
            icon: FluentIcons.ic_fluent_info_24_regular,
            iconToolTip: "Sync enables you to sync your lists across other devices.",
            title: GestureDetector(
              child: NcTitleText("Enable sync"),
              onTap: () => _setSync(!Settings.sync),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                NcBodyText(Settings.sync ? "On" : "Off"),
                Transform.scale(
                  alignment: Alignment.centerRight,
                  scale: .9,
                  child: ToggleSwitch(
                    checked: Settings.sync,
                    onChanged: _setSync,
                  ),
                ),
              ],
            ),
          ),
          InfoBoxContainer(
            padding: settingsContainerPadding(),
            height: settingsContainerHeight(),
            backgroundColor: warningColor.withOpacity(.3),
            margin: settingsContainerMargin(),
            shadow: false,
            borderColor: warningColor.withOpacity(.3),
            title: NcCaptionText("Sync is not implemented yet"),
            icon: FluentIcons.ic_fluent_info_24_regular,
          ),
        ],
      ),
    );
  }
}

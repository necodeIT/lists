part of 'settings_dialog.dart';

/// Sync settings.
class SyncOptions extends StatefulWidget {
  /// Sync settings.
  const SyncOptions({Key? key}) : super(key: key);

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
      header: ExpanderHeader(icon: FluentIcons.ic_fluent_arrow_sync_24_filled, text: S.of(context).sync),
      content: Column(
        children: [
          SettingsContainer(
            icon: FluentIcons.ic_fluent_info_24_regular,
            iconTooltip: S.of(context).syncDescription,
            title: NcTitleText(S.of(context).enableSync),
            onTap: () => _setSync(!Settings.sync),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                NcBodyText(Settings.sync ? S.of(context).on : S.of(context).off),
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
          // SettingsContainer(
          //   color: warningColor.withOpacity(kDefaultOpacity),
          //   title: NcCaptionText("Sync is not implemented yet"),
          //   icon: FluentIcons.ic_fluent_info_24_regular,
          // ),
          InfoBar(
            title: NcCaptionText(S.of(context).syncIsNotImplementedYet),
            severity: InfoBarSeverity.info,
          ),
        ],
      ),
    );
  }
}

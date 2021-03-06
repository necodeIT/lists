part of 'settings_dialog.dart';

/// Sync settings.
class AccountOptions extends StatefulWidget {
  /// Sync settings.
  const AccountOptions({Key? key}) : super(key: key);

  @override
  State<AccountOptions> createState() => _AccountOptionsState();
}

class _AccountOptionsState extends State<AccountOptions> {
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
      header: ExpanderHeader(icon: FluentIcons.ic_fluent_person_24_regular, text: t.account),
      content: Column(
        children: [
          SettingsContainer(
            title: NcCaptionText(t.noAccountLinked),
            icon: FontAwesome.github,
            // TODO: login onTap
            trailing: SettingsIcon(
              icon: FluentIcons.ic_fluent_chevron_right_24_filled,
            ),
          ),
          SettingsContainer(
            icon: FluentIcons.ic_fluent_arrow_sync_24_filled,
            // iconTooltip: t.syncDescription,
            title: NcTitleText(t.enableSync),
            onTap: () => _setSync(!Settings.sync),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                NcBodyText(Settings.sync ? t.on : t.off),
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
          InfoBar(
            title: NcCaptionText(t.syncIsNotImplementedYet),
            severity: InfoBarSeverity.warning,
          ),
          if (!Settings.sync)
            InfoBar(
              title: NcCaptionText(t.syncDescription),
              severity: InfoBarSeverity.info,
            ),
        ],
      ),
    );
  }
}

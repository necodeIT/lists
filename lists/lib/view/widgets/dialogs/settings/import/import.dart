part of '../settings_dialog.dart';

/// Import settings.
class ImportOptions extends StatelessWidget {
  /// Import settings.
  const ImportOptions({Key? key, required this.switchView}) : super(key: key);

  /// Callback in order switch to another view inside the settings dialog.
  final Function(Widget, String) switchView;

  @override
  Widget build(BuildContext context) {
    return Expander(
      contentPadding: 0,
      headerBackgroundColor: expanderHeaderBackground(),
      contentBackgroundColor: expanderContentBackground(),
      initiallyExpanded: false,
      header: ExpanderHeader(icon: FluentIcons.ic_fluent_arrow_import_24_filled, text: S.of(context).import),
      content: Column(
        children: [
          // SettingsContainer(
          //   title: NcTitleText("Export list to file"),
          //   onTap: () {},
          //   trailing: SettingsIcon(icon: FluentIcons.ic_fluent_chevron_right_24_filled),
          // ),
          SettingsContainer(
            title: NcTitleText(S.of(context).importListFromFile),
            onTap: () => switchView(
              Column(
                children: [
                  for (var collection in DB.collections) SettingsListTile(collection: collection),
                ],
              ),
              S.of(context).importListFromFile,
            ),
            trailing: SettingsIcon(icon: FluentIcons.ic_fluent_chevron_right_24_filled),
          ),
          SettingsContainer(
            title: NcTitleText(S.of(context).importListsFromOlderVersions),
            onTap: () {},
            trailing: SettingsIcon(icon: FluentIcons.ic_fluent_chevron_right_24_filled),
          ),
          InfoBar(
            title: NcCaptionText(S.of(context).importingIsNotImplementedYet),
            severity: InfoBarSeverity.info,
          ),
        ],
      ),
    );
  }
}

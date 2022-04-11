part of '../settings_dialog.dart';

/// Import settings.
class ImportOptions extends LocalizedWidget {
  /// Import settings.
  // const ImportOptions({Key? key, required this.switchView}) : super(key: key);
  const ImportOptions({Key? key}) : super(key: key);

  /// Callback in order switch to another view inside the settings dialog.
  // final Function(Widget, String) switchView;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Expander(
      contentPadding: 0,
      headerBackgroundColor: expanderHeaderBackground(),
      contentBackgroundColor: expanderContentBackground(),
      initiallyExpanded: false,
      header: ExpanderHeader(icon: FluentIcons.ic_fluent_arrow_import_24_filled, text: t.import),
      content: Column(
        children: [
          // SettingsContainer(
          //   title: NcTitleText("Export list to file"),
          //   onTap: () {},
          //   trailing: SettingsIcon(icon: FluentIcons.ic_fluent_chevron_right_24_filled),
          // ),
          SettingsContainer(
            title: NcTitleText(t.importListFromFile),
            // onTap: () => switchView(
            //   Column(
            //     children: [
            //       for (var collection in DB.collections) SettingsListTile(collection: collection),
            //     ],
            //   ),
            //   t.importListFromFile,
            // ),
            trailing: SettingsIcon(icon: FluentIcons.ic_fluent_chevron_right_24_filled),
          ),
          SettingsContainer(
            title: NcTitleText(t.importListsFromOlderVersions),
            onTap: () {},
            trailing: SettingsIcon(icon: FluentIcons.ic_fluent_chevron_right_24_filled),
          ),
          InfoBar(
            title: NcCaptionText(t.importingIsNotImplementedYet),
            severity: InfoBarSeverity.warning,
          ),
        ],
      ),
    );
  }
}

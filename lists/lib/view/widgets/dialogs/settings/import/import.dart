part of '../settings_dialog.dart';

/// Import settings.
class ImportOptions extends StatelessWidget {
  /// Import settings.
  const ImportOptions({Key? key, required this.switchView}) : super(key: key);

  final Function(Widget, String) switchView;

  @override
  Widget build(BuildContext context) {
    return Expander(
      contentPadding: 0,
      headerBackgroundColor: expanderHeaderBackground(),
      contentBackgroundColor: expanderContentBackground(),
      initiallyExpanded: false,
      header: ExpanderHeader(icon: FluentIcons.ic_fluent_arrow_import_24_filled, text: "Import"),
      content: Column(
        children: [
          // SettingsContainer(
          //   title: NcTitleText("Export list to file"),
          //   onTap: () {},
          //   trailing: SettingsIcon(icon: FluentIcons.ic_fluent_chevron_right_24_filled),
          // ),
          SettingsContainer(
            title: NcTitleText("Import list from file"),
            onTap: () => switchView(
              Column(
                children: [
                  for (var collection in DB.collections) SettingsListTile(collection: collection),
                ],
              ),
              "Import list from file",
            ),
            trailing: SettingsIcon(icon: FluentIcons.ic_fluent_chevron_right_24_filled),
          ),
          SettingsContainer(
            title: NcTitleText("Import lists from older versions"),
            onTap: () {},
            trailing: SettingsIcon(icon: FluentIcons.ic_fluent_chevron_right_24_filled),
          ),
          SettingsContainer(
            color: warningColor.withOpacity(kDefaultOpacity),
            title: NcCaptionText("Importing is not implemented yet"),
            icon: FluentIcons.ic_fluent_info_24_regular,
          ),
        ],
      ),
    );
  }
}

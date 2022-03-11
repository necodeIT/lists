part of 'settings_dialog.dart';

class LegacyOptions extends StatelessWidget {
  const LegacyOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expander(
      contentPadding: 0,
      headerBackgroundColor: expanderHeaderBackground(),
      contentBackgroundColor: expanderContentBackground(),
      initiallyExpanded: false,
      header: ExpanderHeader(icon: FluentIcons.ic_fluent_apps_add_in_24_filled, text: "Legacy"),
      content: Column(
        children: [
          SettingsContainer(
            title: NcTitleText("Export list to file"),
            onTap: () {},
            trailing: SettingsIcon(icon: FluentIcons.ic_fluent_chevron_right_24_filled),
          ),
          SettingsContainer(
            title: NcTitleText("Import list from file"),
            onTap: () {},
            trailing: SettingsIcon(icon: FluentIcons.ic_fluent_chevron_right_24_filled),
          ),
          SettingsContainer(
            title: NcTitleText("Import lists from older versions"),
            onTap: () {},
            trailing: SettingsIcon(icon: FluentIcons.ic_fluent_chevron_right_24_filled),
          ),
          SettingsContainer(
            color: warningColor.withOpacity(.3),
            title: NcCaptionText("Legacy support is not implemented yet"),
            icon: FluentIcons.ic_fluent_info_24_regular,
          ),
        ],
      ),
    );
  }
}

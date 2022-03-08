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
            trailing: TooltipIconButton(
              onPressed: () {},
              icon: FluentIcons.ic_fluent_window_new_24_filled,
              tooltip: "Export list",
            ),
          ),
          SettingsContainer(
            title: NcTitleText("Import list from file"),
            trailing: TooltipIconButton(
              onPressed: () {},
              icon: FluentIcons.ic_fluent_window_new_24_filled,
              tooltip: "Import list",
            ),
          ),
          SettingsContainer(
            title: NcTitleText("Import lists from older versions"),
            trailing: TooltipIconButton(
              onPressed: () {},
              icon: FluentIcons.ic_fluent_window_new_24_filled,
              tooltip: "Import lists",
            ),
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

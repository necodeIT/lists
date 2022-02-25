import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:lists/db/settings.dart';
import 'package:lists/fluent_icons.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:lists/widgets/expander_header.dart';
import 'package:lists/widgets/info_box_container.dart';
import 'package:lists/widgets/tooltip_icon_button.dart';
import 'package:lists/widgets/vertical_divider.dart';
import 'package:nekolib_ui/core.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  State<SettingsDialog> createState() => SettingsDialogState();
}

class SettingsDialogState extends State<SettingsDialog> {
  _setTheme(String theme) {
    setState(() {
      Settings.setTheme(theme);
    });
  }

  _setAdaptAccent(bool? value) {
    setState(() {
      Settings.setAdaptAccent(value ?? false);
    });
  }

  _setSync(bool? value) {
    setState(() {
      Settings.setSync(value ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 700),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NcTitleText("Settings"),
          TooltipIconButton(
            tooltip: "Close",
            icon: Icons.close,
            size: 25,
            onPressed: Navigator.of(context).pop,
          ),
        ],
      ),
      content: Column(
        children: [
          Expander(
            contentPadding: 0,
            initiallyExpanded: true,
            headerBackgroundColor: expanderHeaderBackground(),
            contentBackgroundColor: expanderContentBackground(),
            header: ExpanderHeader(icon: FluentIcons.ic_fluent_color_24_regular, text: "Appearance"),
            content: Column(
              children: [
                InfoBoxContainer(
                  padding: expanderInfoBoxContainerPadding(),
                  margin: expanderInfoBoxContainerMargin(),
                  height: expanderInfoBoxContainerHeight(),
                  backgroundColor: expanderInfoBoxContainerBackroundColor(),
                  shadow: false,
                  borderColor: Colors.transparent,
                  title: NcTitleText("Select theme"),
                  trailing: FluentTheme(
                    data: ThemeData(
                      buttonTheme: ButtonThemeData(
                        defaultButtonStyle: buttonStyle(tertiaryColor.withOpacity(.2), 0, BorderStyle.none),
                      ),
                    ),
                    child: DropDownButton(
                      menuDecoration: dropDownButtonMenuStyle(),
                      title: NcCaptionText(Settings.theme),
                      items: [
                        for (var theme in NcThemes.all.keys)
                          DropDownButtonItem(
                            onTap: () => _setTheme(theme),
                            title: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FluentVertivalDvider(color: Settings.theme == theme ? adaptiveAccentColor : Colors.transparent),
                                NcSpacing.xs(),
                                NcCaptionText(theme),
                              ],
                            ),
                          ),
                        DropDownButtonItem(
                          onTap: () => _setTheme(Settings.systemTheme),
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FluentVertivalDvider(color: Settings.useSystemTheme ? adaptiveAccentColor : Colors.transparent),
                              NcSpacing.xs(),
                              NcCaptionText(Settings.systemTheme),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InfoBoxContainer(
                  padding: expanderInfoBoxContainerPadding(),
                  height: expanderInfoBoxContainerHeight(),
                  backgroundColor: expanderInfoBoxContainerBackroundColor(),
                  margin: expanderInfoBoxContainerMargin(),
                  shadow: false,
                  borderColor: Colors.transparent,
                  icon: Settings.useSystemTheme ? null : FluentIcons.ic_fluent_error_circle_24_regular,
                  iconToolTip: "Adaptive accent is only available when using system theme",
                  title: GestureDetector(
                    child: NcTitleText("Adaptive accent"),
                    onTap: Settings.useSystemTheme ? () => _setAdaptAccent(!Settings.adaptAccent) : null,
                  ),
                  trailing: Checkbox(
                    checked: Settings.adaptAccent,
                    onChanged: Settings.useSystemTheme ? _setAdaptAccent : null,
                  ),
                ),
                if (Settings.adaptAccent)
                  InfoBoxContainer(
                    padding: expanderInfoBoxContainerPadding(),
                    height: expanderInfoBoxContainerHeight(),
                    backgroundColor: warningColor.withOpacity(.3),
                    margin: expanderInfoBoxContainerMargin(),
                    shadow: false,
                    borderColor: warningColor.withOpacity(.3),
                    title: GestureDetector(
                      child: NcCaptionText("Adaptive accent is not implemented yet"),
                      onTap: () => _setAdaptAccent(false),
                    ),
                    icon: FluentIcons.ic_fluent_info_24_regular,
                    // iconColor: warningColor,
                  ),
              ],
            ),
          ),
          NcSpacing.xs(),
          Expander(
            contentPadding: 0,
            headerBackgroundColor: expanderHeaderBackground(),
            contentBackgroundColor: expanderContentBackground(),
            initiallyExpanded: false,
            header: ExpanderHeader(icon: FluentIcons.ic_fluent_arrow_sync_24_filled, text: "Sync"),
            content: Column(
              children: [
                InfoBoxContainer(
                  padding: expanderInfoBoxContainerPadding(),
                  height: expanderInfoBoxContainerHeight(),
                  backgroundColor: expanderInfoBoxContainerBackroundColor(),
                  margin: expanderInfoBoxContainerMargin(),
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
              ],
            ),
          ),
          NcSpacing.xs(),
          Expander(
            contentPadding: 0,
            headerBackgroundColor: expanderHeaderBackground(),
            contentBackgroundColor: expanderContentBackground(),
            initiallyExpanded: false,
            header: ExpanderHeader(icon: FluentIcons.ic_fluent_apps_add_in_24_filled, text: "Legacy"),
            content: Column(
              children: [
                InfoBoxContainer(
                  padding: expanderInfoBoxContainerPadding(),
                  height: expanderInfoBoxContainerHeight(),
                  backgroundColor: expanderInfoBoxContainerBackroundColor(),
                  margin: expanderInfoBoxContainerMargin(),
                  borderColor: Colors.transparent,
                  shadow: false,
                  title: NcTitleText("Export list to file"),
                  trailing: TooltipIconButton(
                    onPressed: () {},
                    icon: FluentIcons.ic_fluent_window_new_24_filled,
                    tooltip: "Export list",
                  ),
                ),
                InfoBoxContainer(
                  padding: expanderInfoBoxContainerPadding(),
                  height: expanderInfoBoxContainerHeight(),
                  backgroundColor: expanderInfoBoxContainerBackroundColor(),
                  margin: expanderInfoBoxContainerMargin(),
                  borderColor: Colors.transparent,
                  shadow: false,
                  title: NcTitleText("Import list from file"),
                  trailing: TooltipIconButton(
                    onPressed: () {},
                    icon: FluentIcons.ic_fluent_window_new_24_filled,
                    tooltip: "Import list",
                  ),
                ),
                InfoBoxContainer(
                  padding: expanderInfoBoxContainerPadding(),
                  height: expanderInfoBoxContainerHeight(),
                  backgroundColor: expanderInfoBoxContainerBackroundColor(),
                  margin: expanderInfoBoxContainerMargin(),
                  borderColor: Colors.transparent,
                  shadow: false,
                  title: NcTitleText("Import lists from older versions"),
                  trailing: TooltipIconButton(
                    onPressed: () {},
                    icon: FluentIcons.ic_fluent_window_new_24_filled,
                    tooltip: "Import lists",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

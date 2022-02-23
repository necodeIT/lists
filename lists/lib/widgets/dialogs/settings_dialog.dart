import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/db/settings.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:lists/widgets/tooltip_icon_button.dart';
import 'package:lists/widgets/vertical_divider.dart';
import 'package:nekolib_ui/core.dart';
import 'package:flutter/material.dart' show Icons, VerticalDivider;

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

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NcTitleText("Settings"),
          TooltipIconButton(
            tooltip: "Close",
            icon: Icons.close,
            size: 20,
            onPressed: Navigator.of(context).pop,
          ),
        ],
      ),
      content: Column(
        children: [
          Expander(
            contentPadding: 0,
            initiallyExpanded: true,
            contentBackgroundColor: secondaryColor.withOpacity(.7),
            headerBackgroundColor: ButtonState.all(secondaryColor),
            header: NcTitleText("Themes"),
            content: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NcTitleText("Theme"),
                      DropDownButton(
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
                    ],
                  ),
                ),
                Container(color: primaryColor, width: double.infinity, height: 1.5),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Checkbox(
                      checked: Settings.adaptAccent,
                      onChanged: Settings.useSystemTheme ? _setAdaptAccent : null,
                      content: NcCaptionText("Use system accent color"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // if (Settings.useSystemTheme) NcSpacing.xs(),
          // if (Settings.useSystemTheme)
        ],
      ),
    );
  }
}

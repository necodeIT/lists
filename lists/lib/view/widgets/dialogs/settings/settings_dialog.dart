import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:lists/models/settings.dart';
import 'package:lists/models/updater.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/view/styles/styles.dart';
import 'package:lists/helpers/system_theme.dart';
import 'package:lists/view/routes/upgrade/upgrade.dart';
import 'package:lists/view/widgets/dialogs/settings/icon.dart';
import 'package:lists/view/widgets/dialogs/settings/settings_container.dart';
import 'package:lists/view/widgets/expander_header.dart';
import 'package:lists/view/widgets/info_box_container.dart';
import 'package:lists/view/widgets/tooltip_icon_button.dart';
import 'package:lists/view/widgets/vertical_divider.dart';
import 'package:nekolib_ui/core.dart';

part 'appearance.dart';
part 'sync.dart';
part 'import.dart';
part 'general.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  State<SettingsDialog> createState() => SettingsDialogState();
}

class SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      scrollContent: true,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          GeneralOptions(),
          NcSpacing.xs(),
          AppearanceOptions(),
          NcSpacing.xs(),
          SyncOptions(),
          NcSpacing.xs(),
          LegacyOptions(),
        ],
      ),
    );
  }
}

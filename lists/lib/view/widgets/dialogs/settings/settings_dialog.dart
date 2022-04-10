import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lists/controller/controller.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:lists/models/db.dart';
import 'package:lists/models/settings.dart';
import 'package:lists/models/updater.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/view/styles/styles.dart';
import 'package:lists/helpers/system_theme.dart';
import 'package:lists/view/routes/upgrade/upgrade.dart';
import 'package:lists/view/widgets/dialogs/settings/icon.dart';
import 'package:lists/view/widgets/dialogs/settings/settings_container.dart';
import 'package:lists/view/widgets/expander_header.dart';
import 'package:lists/view/widgets/localized_widget.dart';
import 'package:lists/view/widgets/tooltip_icon_button.dart';
import 'package:nekolib_ui/core.dart';

import 'import/list_tile.dart';

part 'appearance.dart';
part 'sync.dart';
part 'import/import.dart';
part 'general.dart';

/// Dialog which allows the user to change the settings.
class SettingsDialog extends StatefulWidget {
  /// Dialog which allows the user to change the settings.
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> with TickerProviderStateMixin {
  // AnimationController? _controller;

  // Widget? child;
  // String? title;

  // void switchView(Widget? child, String? title) {
  //   setState(() {
  //     this.child = child;
  //     this.title = title;
  //   });

  //   _controller?.reset();
  //   _controller!.forward();
  // }

  @override
  Widget build(BuildContext context) {
    // if (_controller == null) {
    //   _controller = AnimationController(vsync: this, duration: FluentTheme.of(context).fastAnimationDuration);
    //   _controller!.forward();
    // }

    return FluentTheme(
      data: theme().copyWith(
        buttonTheme: ButtonThemeData(
          filledButtonStyle: filledButtonStyle(),
          defaultButtonStyle: buttonStyle(
            hoverColor: secondaryColor,
          ),
        ),
      ),
      child: ContentDialog(
        scrollContent: true,
        constraints: const BoxConstraints(maxWidth: 700),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // if (child != null)
                //   TooltipIconButton.small(
                //     tooltip: "Go back to settings",
                //     icon: FluentIcons.ic_fluent_arrow_left_24_filled,
                //     onPressed: () => switchView(null, null),
                //   ),
                // if (child != null) NcSpacing.small(),
                // NcTitleText(title ?? AppLocalizations.of(context)!.settings),
                NcTitleText(t.settings),
              ],
            ),
            TooltipIconButton(
              tooltip: AppLocalizations.of(context)!.close,
              icon: Icons.close,
              size: 25,
              onPressed: Navigator.of(context).pop,
            ),
          ],
        ),
        content: AnimatedSize(
          curve: FluentTheme.of(context).animationCurve,
          duration: FluentTheme.of(context).fastAnimationDuration,
          // child: HorizontalSlidePageTransition(
          //   animation: _controller!,
          //   child: ConditionalWidget(
          //     condition: child != null,
          //     trueWidget: (context) => child!,
          //     falseWidget: (context) => Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         GeneralOptions(),
          //         NcSpacing.xs(),
          //         AppearanceOptions(),
          //         NcSpacing.xs(),
          //         SyncOptions(),
          //         NcSpacing.xs(),
          //         ImportOptions(switchView: switchView),
          //       ],
          //     ),
          //   ),
          // ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GeneralOptions(),
              NcSpacing.xs(),
              AppearanceOptions(),
              NcSpacing.xs(),
              SyncOptions(),
              NcSpacing.xs(),
              ImportOptions(),
            ],
          ),
        ),
      ),
    );
  }
}

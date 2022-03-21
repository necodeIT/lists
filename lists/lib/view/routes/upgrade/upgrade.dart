import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lists/controller/controller.dart';
import 'package:lists/models/updater.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:nekolib_ui/core.dart';
import 'package:url_launcher/url_launcher.dart';

class UpgradeRoute extends StatefulWidget {
  const UpgradeRoute({Key? key}) : super(key: key);

  static const routeName = "/upgrade";

  @override
  State<UpgradeRoute> createState() => _UpgradeRouteState();
}

class _UpgradeRouteState extends State<UpgradeRoute> {
  void _showErrorDialog() {
    showConfirmDialog(
      context: context,
      title: "Error updating",
      message: "The update failed to download.\nPlease try again later or update manually.",
      onConfirm: () => launch(Updater.setupDownloadUrl),
      confirmText: "Download",
    );
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;

    return Consumer(builder: (context, ref, _) {
      var updater = ref.watch(updaterProvider);

      void upgrade() => updater.upgrade(_showErrorDialog);

      if (args != null && args as bool) upgrade;
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: secondaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (updater.error)
              Icon(
                FluentIcons.ic_fluent_error_circle_24_filled,
                size: 80,
                color: errorColor,
              ),
            if (updater.error) NcSpacing.medium(),
            if (updater.error)
              NcTitleText(
                "The update failed to download. Please try again later or update manually.",
                fontSize: 20,
              ),
            if (updater.error) NcSpacing.medium(),
            if (updater.error)
              FilledButton(
                style: filledButtonStyle(),
                child: NcCaptionText(
                  "Update manually",
                  buttonText: true,
                  textAlign: TextAlign.center,
                  fontSize: 15,
                ),
                onPressed: () => launch(Updater.setupDownloadUrl),
              ),
            if (!updater.downloading && !updater.error)
              Icon(
                FluentIcons.ic_fluent_arrow_circle_up_24_regular,
                size: 80,
              ),
            if (!updater.downloading && !updater.error) NcSpacing.medium(),
            if (!updater.downloading && !updater.error)
              FilledButton(
                style: filledButtonStyle(),
                child: NcCaptionText(
                  "Upgrade to ${updater.latestVersionName}",
                  buttonText: true,
                  textAlign: TextAlign.center,
                  fontSize: 15,
                ),
                onPressed: upgrade,
              ),
            if (updater.downloading && !updater.error)
              NcTitleText(
                updater.done ? "Launching installer..." : "Downloading updates (${updater.progress}%)...",
                fontSize: 20,
              ),
            if (updater.downloading && !updater.error) NcSpacing.medium(),
            if (updater.downloading && !updater.error)
              ProgressBar(
                width: 400,
                backgroundColor: tertiaryColor,
                value: updater.progress.toDouble(),
                strokeWidth: 5,
                activeColor: adaptiveAccentColor,
              ),
          ],
        ),
      );
    });
  }
}

import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/assets/assets.dart';
import 'package:lists/models/updater.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:lists/view/widgets/window_handle.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_ui/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class UpgradeRoute extends StatefulWidget {
  const UpgradeRoute({Key? key}) : super(key: key);

  static const routeName = "/upgrade";

  @override
  State<UpgradeRoute> createState() => _UpgradeRouteState();
}

class _UpgradeRouteState extends State<UpgradeRoute> {
  int _progress = 0;
  bool _downloading = false;
  bool _done = false;
  bool _error = false;

  _updateProgress(int p0, int p1) {
    setState(() {
      _progress = (p0 / p1 * 100).floor();
    });
  }

  _upgrade() {
    if (_downloading) return;

    setState(() {
      _downloading = true;
    });

    _error = true;

    Updater.upgrade(_updateProgress).then((value) async {
      if (!mounted) return;

      if (!await File(value).exists()) {
        _error = true;

        return;
      }

      setState(() {
        _done = true;
      });

      await Process.start(value, []);

      exit(0);
    });

    if (_error) {
      setState(() {});

      showConfirmDialog(
        context: context,
        title: "Error updating",
        message: "The update failed to download.\nPlease try again later or update manually.",
        onConfirm: () => launch(Updater.setupDownloadUrl),
        onCancel: () => exit(0),
        confirmText: "Download",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;

    if (args != null && args as bool) _upgrade();

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: secondaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_error)
            Icon(
              FluentIcons.ic_fluent_error_circle_24_filled,
              size: 80,
              color: errorColor,
            ),
          if (_error) NcSpacing.medium(),
          if (_error)
            NcTitleText(
              "The update failed to download. Please try again later or update manually.",
              fontSize: 20,
            ),
          if (_error) NcSpacing.medium(),
          if (_error)
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
          if (!_downloading && !_error)
            Icon(
              FluentIcons.ic_fluent_arrow_circle_up_24_regular,
              size: 80,
            ),
          if (!_downloading && !_error) NcSpacing.medium(),
          if (!_downloading && !_error)
            FilledButton(
              style: filledButtonStyle(),
              child: NcCaptionText(
                "Upgrade to ${Updater.latestVersionName}",
                buttonText: true,
                textAlign: TextAlign.center,
                fontSize: 15,
              ),
              onPressed: _upgrade,
            ),
          if (_downloading && !_error)
            NcTitleText(
              _done ? "Launching installer..." : "Downloading updates ($_progress%)...",
              fontSize: 20,
            ),
          if (_downloading && !_error) NcSpacing.medium(),
          if (_downloading && !_error)
            ProgressBar(
              width: 400,
              backgroundColor: tertiaryColor,
              value: _progress.toDouble(),
              strokeWidth: 5,
              activeColor: adaptiveAccentColor,
            ),
        ],
      ),
    );
  }
}

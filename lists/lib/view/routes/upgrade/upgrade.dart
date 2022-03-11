import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/models/updater.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:nekolib_ui/core.dart';

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
    Updater.upgrade(_updateProgress).then((value) async {
      if (!await File(value).exists()) {
        setState(() {
          showAlertDialog(context, "Error updating", "The update failed to download.\nPlease try again later or update manually.");
        });

        return;
      }

      setState(() {
        _done = true;
      });

      await Process.start(value, []);

      exit(0);
    });
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
        children: [
          NcTitleText(
            _downloading
                ? _done
                    ? "Launching installer..."
                    : "Downloading updates ($_progress%)..."
                : "New update available!",
            fontSize: 20,
          ),
          NcSpacing.medium(),
          !_downloading
              ? FilledButton(
                  style: filledButtonStyle(),
                  child: NcCaptionText(
                    "Upgrade to ${Updater.latestVersionName}",
                    buttonText: true,
                    textAlign: TextAlign.center,
                    fontSize: 15,
                  ),
                  onPressed: _upgrade,
                )
              : ProgressBar(
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

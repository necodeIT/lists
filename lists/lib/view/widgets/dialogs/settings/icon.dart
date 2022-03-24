import 'package:fluent_ui/fluent_ui.dart';
import 'package:nekolib_ui/core.dart';

/// Icon used in the settings dialog.
class SettingsIcon extends StatelessWidget {
  /// Icon used in the settings dialog.
  const SettingsIcon({Key? key, required this.icon}) : super(key: key);

  /// Icon to display.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: textColor,
      size: 18,
    );
  }
}

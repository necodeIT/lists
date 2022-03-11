import 'package:fluent_ui/fluent_ui.dart';
import 'package:nekolib_ui/core.dart';

class SettingsIcon extends StatelessWidget {
  const SettingsIcon({Key? key, required this.icon}) : super(key: key);

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

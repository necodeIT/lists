import 'package:fluent_ui/fluent_ui.dart';
import 'package:nekolib_ui/core.dart';

/// Themed expander header for the settings dialog.
class ExpanderHeader extends StatelessWidget {
  /// Themed expander header for the settings dialog.
  const ExpanderHeader({Key? key, required this.icon, required this.text}) : super(key: key);

  /// The size of the icon.
  static const double iconSize = 22;

  /// The size of the text.
  static const double fontSize = 17;

  /// The icon to display.
  final IconData icon;

  /// The text to display.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: iconSize),
        NcSpacing.small(),
        NcTitleText(text, fontSize: fontSize),
      ],
    );
  }
}

import 'package:fluent_ui/fluent_ui.dart';
import 'package:nekolib_ui/core.dart';

class ExpanderHeader extends StatelessWidget {
  const ExpanderHeader({Key? key, required this.icon, required this.text}) : super(key: key);

  static const double iconSize = 22;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: iconSize),
        NcSpacing.small(),
        NcTitleText(text),
      ],
    );
  }
}

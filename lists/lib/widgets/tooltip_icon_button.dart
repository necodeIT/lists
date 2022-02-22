import 'package:fluent_ui/fluent_ui.dart';
import 'package:nekolib_ui/core.dart';

class TooltipIconButton extends StatelessWidget {
  const TooltipIconButton({Key? key, required this.tooltip, required this.icon, this.onPressed, this.size}) : super(key: key);

  final String tooltip;
  final IconData icon;
  final VoidCallback? onPressed;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(
          icon,
          color: textColor,
          size: size,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

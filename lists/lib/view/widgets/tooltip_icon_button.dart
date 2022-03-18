import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:lists/view/widgets/hover_region.dart';
import 'package:nekolib_ui/core.dart';

class TooltipIconButton extends StatelessWidget {
  const TooltipIconButton({
    Key? key,
    required this.tooltip,
    required this.icon,
    this.onPressed,
    this.size = 18,
    this.color,
  })  : small = false,
        super(key: key);

  const TooltipIconButton.small({
    Key? key,
    required this.tooltip,
    required this.icon,
    this.onPressed,
    this.size = 16,
    this.color,
  })  : small = true,
        super(key: key);

  final String tooltip;
  final IconData icon;
  final VoidCallback? onPressed;
  final double? size;
  final Color? color;
  final bool small;

  @override
  Widget build(BuildContext context) {
    var child = Icon(
      icon,
      color: color ?? textColor,
      size: size,
    );
    return Tooltip(
      message: tooltip,
      child: small
          ? HoverRegion(
              padding: EdgeInsets.all(4),
              onTap: onPressed,
              child: child,
            )
          : IconButton(
              style: iconButtonStyle(),
              icon: child,
              onPressed: onPressed,
            ),
    );
  }
}

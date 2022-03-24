import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/view/styles/styles.dart';
import 'package:lists/view/widgets/hover_region.dart';
import 'package:nekolib_ui/core.dart';

/// Icon button with a tooltip.
class TooltipIconButton extends StatelessWidget {
  /// Icon button with a tooltip.
  const TooltipIconButton({
    Key? key,
    required this.tooltip,
    required this.icon,
    this.onPressed,
    this.size = 18,
    this.color,
  })  : small = false,
        super(key: key);

  /// Smaller icon button with a tooltip.
  const TooltipIconButton.small({
    Key? key,
    required this.tooltip,
    required this.icon,
    this.onPressed,
    this.size = 16,
    this.color,
  })  : small = true,
        super(key: key);

  /// The tooltip to display.
  final String tooltip;

  /// The icon to display.
  final IconData icon;

  /// On pressed callback.
  final VoidCallback? onPressed;

  /// Size of the icon.
  final double? size;

  /// Color of the icon.
  final Color? color;

  /// Whether to use the small version.
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

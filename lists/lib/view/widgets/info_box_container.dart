import 'package:fluent_ui/fluent_ui.dart';
import 'package:nekolib_ui/core.dart';

/// Themed [InfoBar].
class InfoBoxContainer extends StatelessWidget {
  /// Themed [InfoBar].
  const InfoBoxContainer({
    Key? key,
    this.backgroundColor,
    this.borderColor,
    this.padding = const EdgeInsets.all(8),
    this.margin,
    this.height,
    this.shadow = true,
    this.iconColor,
    this.title,
    this.icon,
    this.trailing,
    this.iconSize = 20,
    this.iconToolTip,
    this.width,
  }) : super(key: key);

  /// The background color of the info box.
  final Color? backgroundColor;

  /// The border color of the info box.
  final Color? borderColor;

  /// The color of the icon.
  final Color? iconColor;

  /// The padding of the info box.
  final EdgeInsets padding;

  /// The margin of the info box.
  final EdgeInsets? margin;

  /// The height of the info box.
  final double? height;

  /// The width of the info box.
  final double? width;

  /// Whether to show the shadow.
  final bool shadow;

  /// The title of the info box.
  final Widget? title;

  /// The icon of the info box.
  final IconData? icon;

  /// The trailing widget of the info box.
  final Widget? trailing;

  /// The size of the icon.
  final double iconSize;

  /// The tooltip of the icon.
  final String? iconToolTip;

  /// Default decoration for the info box.
  static Decoration decoration({Color? backgroundColor, Color? borderColor, bool shadow = true}) => BoxDecoration(
        color: backgroundColor ?? primaryColor,
        border: Border.all(
          color: borderColor ?? tertiaryColor,
        ),
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: shadow ? kElevationToShadow[1] : null,
      );
  @override
  Widget build(BuildContext context) {
    var icon = Icon(
      this.icon,
      color: iconColor,
      size: iconSize,
    );

    return AnimatedContainer(
      duration: FluentTheme.of(context).fasterAnimationDuration,
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: decoration(backgroundColor: backgroundColor, borderColor: borderColor, shadow: shadow),
      child: Row(
        children: [
          if (this.icon != null && iconToolTip != null) Tooltip(message: iconToolTip, child: icon),
          if (this.icon != null && iconToolTip == null) icon,
          if (this.icon != null) NcSpacing.small(),
          if (title != null)
            Expanded(
              child: title!,
            ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

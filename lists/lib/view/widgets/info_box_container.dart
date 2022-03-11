import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/view/widgets/expander_header.dart';
import 'package:nekolib_ui/core.dart';

class InfoBoxContainer extends StatelessWidget {
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

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final bool shadow;
  final Widget? title;
  final IconData? icon;
  final Widget? trailing;
  final double iconSize;
  final String? iconToolTip;

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

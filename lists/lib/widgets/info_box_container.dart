import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/widgets/expander_header.dart';
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
  }) : super(key: key);

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final double? height;
  final bool shadow;
  final Widget? title;
  final IconData? icon;
  final Widget? trailing;
  final double iconSize;
  final String? iconToolTip;

  @override
  Widget build(BuildContext context) {
    var icon = Icon(
      this.icon,
      color: iconColor,
      size: iconSize,
    );

    return Container(
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? primaryColor,
        border: Border.all(
          color: borderColor ?? tertiaryColor,
        ),
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: shadow ? kElevationToShadow[1] : null,
      ),
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

import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/view/widgets/info_box_container.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_ui/utils.dart';

final ThemeableProperty<double> _opacity = ThemeableProperty<double>.only(.25, {sakuraTheme: 1, oceanTheme: .5});

/// Default opacity to use for transparent info boxes.
double get kDefaultOpacity => _opacity.value;

/// Container for any settings item.
class SettingsContainer extends StatelessWidget {
  /// Container for any settings item.
  const SettingsContainer({Key? key, required this.title, this.color, this.trailing, this.icon, this.iconTooltip, this.onTap, this.hoverColor, this.border = false}) : super(key: key);

  /// Title of the settings item.
  final Widget title;

  /// Color of the settings item.
  final Color? color;

  /// Color of the settings item when hovered.
  final Color? hoverColor;

  /// Trailing widget of the settings item.
  final Widget? trailing;

  /// Icon of the settings item.
  final IconData? icon;

  /// Tooltip of the settings item.
  final String? iconTooltip;

  /// On tap callback.
  final VoidCallback? onTap;

  /// Whether to draw a border around the settings item.
  final bool border;

  /// Default padding for the settings item.
  static const padding = EdgeInsets.symmetric(horizontal: 16);

  /// Default margin for the settings item.
  static const margin = EdgeInsets.symmetric(vertical: 1);

  /// Default height for the settings item.
  static const double height = 50;

  /// Default value whether use shadow.
  static const shadow = false;

  @override
  Widget build(BuildContext context) {
    return ConditionalWrapper(
      condition: onTap != null,
      wrapper: (context, child) => GestureDetector(
        onTap: onTap,
        child: HoverBuilder(
          builder: (context, hovering) {
            var backgroundColor = hovering ? hoverColor ?? primaryColor.withOpacity(.7) : color ?? primaryColor;
            var borderColor = hovering ? hoverColor ?? Colors.transparent : color ?? Colors.transparent;

            return InfoBoxContainer(
              padding: padding,
              height: height,
              margin: margin,
              shadow: shadow,
              backgroundColor: backgroundColor,
              borderColor: border ? borderColor : Colors.transparent,
              icon: icon,
              iconToolTip: iconTooltip,
              title: title,
              trailing: trailing,
            );
          },
        ),
      ),
      child: InfoBoxContainer(
        padding: padding,
        height: height,
        margin: margin,
        shadow: shadow,
        backgroundColor: color ?? primaryColor,
        borderColor: border ? color ?? Colors.transparent : Colors.transparent,
        icon: icon,
        iconToolTip: iconTooltip,
        title: title,
        trailing: trailing,
      ),
    );
  }
}

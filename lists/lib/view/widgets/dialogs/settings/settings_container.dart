import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/models/settings.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:lists/view/widgets/info_box_container.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_ui/utils.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({Key? key, required this.title, this.color, this.trailing, this.icon, this.iconTooltip, this.onTap, this.hoverColor}) : super(key: key);

  final Widget title;
  final Color? color;
  final Color? hoverColor;
  final Widget? trailing;
  final IconData? icon;
  final String? iconTooltip;
  final VoidCallback? onTap;

  static const edgeInsets = EdgeInsets.symmetric(horizontal: 16);
  static const edgeInsets2 = EdgeInsets.symmetric(vertical: 1);
  static const double height = 50;
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
              padding: edgeInsets,
              height: height,
              margin: edgeInsets2,
              shadow: shadow,
              backgroundColor: backgroundColor,
              borderColor: borderColor,
              icon: icon,
              iconToolTip: iconTooltip,
              title: title,
              trailing: trailing,
            );
          },
        ),
      ),
      child: InfoBoxContainer(
        padding: edgeInsets,
        height: height,
        margin: edgeInsets2,
        shadow: shadow,
        backgroundColor: color ?? primaryColor,
        borderColor: color ?? Colors.transparent,
        icon: icon,
        iconToolTip: iconTooltip,
        title: title,
        trailing: trailing,
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: HoverBuilder(
        builder: (context, hovering) {
          var backgroundColor = hovering && onTap != null ? hoverColor ?? secondaryColor.withOpacity(.1) : color ?? secondaryColor;
          var borderColor = hovering && onTap != null ? hoverColor ?? Colors.transparent : color ?? Colors.transparent;

          return InfoBoxContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            backgroundColor: backgroundColor,
            margin: const EdgeInsets.symmetric(vertical: 1),
            shadow: false,
            borderColor: borderColor,
            icon: icon,
            iconToolTip: iconTooltip,
            title: title,
            trailing: trailing,
          );
        },
      ),
    );
  }
}

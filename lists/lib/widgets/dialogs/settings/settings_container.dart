import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/db/settings.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:lists/widgets/info_box_container.dart';
import 'package:nekolib_ui/core.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({Key? key, required this.title, this.color, this.trailing, this.icon, this.iconTooltip}) : super(key: key);

  final Widget title;
  final Color? color;
  final Widget? trailing;
  final IconData? icon;
  final String? iconTooltip;

  @override
  Widget build(BuildContext context) {
    return InfoBoxContainer(
      padding: settingsContainerPadding(),
      height: settingsContainerHeight(),
      backgroundColor: color ?? settingsContainerBackroundColor(),
      margin: settingsContainerMargin(),
      shadow: false,
      borderColor: color ?? Colors.transparent,
      icon: icon,
      iconToolTip: iconTooltip,
      title: title,
      trailing: trailing,
    );
  }
}

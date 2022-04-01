import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/assets/assets.dart';
import 'package:lists/models/collection.dart';
import 'package:lists/view/widgets/dialogs/settings/settings_container.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_ui/utils.dart';

/// Selectable list tile.
class SettingsListTile extends StatefulWidget {
  /// Selectable list tile.
  const SettingsListTile({Key? key, required this.collection}) : super(key: key);

  final Collection collection;

  static const iconSize = 30.0;

  @override
  State<SettingsListTile> createState() => _SettingsListTileState();
}

class _SettingsListTileState extends State<SettingsListTile> {
  @override
  Widget build(BuildContext context) {
    return SettingsContainer(
      title: Row(
        children: [
          ClipOval(
            child: ConditionalWidget(
              condition: widget.collection.hasIcon,
              trueWidget: (context) => Image.memory(
                widget.collection.icon,
                width: SettingsListTile.iconSize,
                height: SettingsListTile.iconSize,
              ),
              falseWidget: (context) => Image.asset(
                img_default_list_icon,
                width: SettingsListTile.iconSize,
                height: SettingsListTile.iconSize,
                color: textColor,
              ),
            ),
          ),
          NcSpacing.medium(),
          NcTitleText(widget.collection.name),
        ],
      ),
    );
  }
}

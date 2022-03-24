import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/view/widgets/hover_region.dart';
import 'package:nekolib_ui/core.dart';

/// Themed context menu item.
class ContextMenuItem extends StatelessWidget {
  /// Themed context menu item.
  const ContextMenuItem({Key? key, required this.onTap, this.icon, required this.title}) : super(key: key);

  /// On tap callback.
  final VoidCallback onTap;

  /// Icon of the item.
  final IconData? icon;

  /// Title of the item.
  final String title;

  @override
  Widget build(BuildContext context) {
    return HoverRegion(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, size: 14),
          if (icon != null) NcSpacing.xs(),
          NcCaptionText(title, fontSize: 14),
        ],
      ),
      onTap: onTap,
    );
  }
}

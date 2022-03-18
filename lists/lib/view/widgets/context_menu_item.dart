import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/view/widgets/hover_region.dart';
import 'package:nekolib_ui/core.dart';

class ContextMenuItem extends StatelessWidget {
  const ContextMenuItem({Key? key, required this.onTap, this.icon, required this.title}) : super(key: key);

  final VoidCallback onTap;
  final IconData? icon;
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

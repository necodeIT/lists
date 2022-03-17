import 'package:fluent_ui/fluent_ui.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_ui/utils.dart';

class HoverRegion extends StatelessWidget {
  const HoverRegion({Key? key, required this.child, this.onTap}) : super(key: key);

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      onTap: onTap,
      builder: (context, hovering) => Container(
        padding: EdgeInsets.all(8),
        child: child,
        decoration: hovering
            ? BoxDecoration(
                color: tertiaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              )
            : null,
      ),
    );
  }
}

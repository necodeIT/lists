import 'package:fluent_ui/fluent_ui.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_ui/utils.dart';

/// Themed hover region.
class HoverRegion extends StatelessWidget {
  /// Themed hover region.
  const HoverRegion({Key? key, required this.child, this.onTap, this.padding}) : super(key: key);

  /// The child of the hover region.
  final Widget child;

  /// On tap callback.
  final VoidCallback? onTap;

  /// Padding of the hover region.
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      onTap: onTap,
      builder: (context, hovering) => Container(
        padding: padding ?? EdgeInsets.all(8),
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

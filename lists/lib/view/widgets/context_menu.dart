import 'package:fluent_ui/fluent_ui.dart';
import 'package:nekolib_ui/core.dart';

/// Context menu flyout.
class ContextMenu extends StatelessWidget {
  /// Context menu flyout.
  const ContextMenu({Key? key, required this.child}) : super(key: key);

  /// The child of the context menu.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FlyoutContent(
      padding: const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: BorderSide(
          color: secondaryColor,
          width: 1.5,
        ),
      ),
      color: primaryColor,
      child: child,
    );
  }
}

import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';

/// Wraps a route in all widgets needed for the app to function.
class Route extends StatelessWidget {
  /// Wraps a route in all widgets needed for the app to function.
  const Route({Key? key, required this.child}) : super(key: key);

  /// The actual route.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ContextMenuOverlay(child: child);
  }
}

import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Route extends StatelessWidget {
  const Route({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ContextMenuOverlay(child: child);
  }
}

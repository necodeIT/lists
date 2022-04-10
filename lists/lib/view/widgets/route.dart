import 'package:context_menus/context_menus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lists/controller/controller.dart';

/// Wraps a route in all widgets needed for the app to function.
class Route extends StatelessWidget {
  /// Wraps a route in all widgets needed for the app to function.
  const Route({Key? key, required this.builder}) : super(key: key);

  /// The actual route.
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return ContextMenuOverlay(
      child: Consumer(
        builder: (context, ref, _) {
          ref.watch(localeProvider);
          return builder(context);
        },
      ),
    );
  }
}

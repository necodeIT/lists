import 'package:fluent_ui/fluent_ui.dart';
import 'package:nekolib_ui/core.dart';

/// Vertical divider.
class FluentVertivalDvider extends StatelessWidget {
  /// Vertical divider.
  const FluentVertivalDvider({Key? key, this.color}) : super(key: key);

  /// The color of the divider.
  /// If not specified, defaults to [textColor].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: 3,
      decoration: BoxDecoration(
        color: color ?? textColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

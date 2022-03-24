import 'package:fluent_ui/fluent_ui.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_ui/utils.dart';

/// Card used for the home screen.
class HomeCard extends StatelessWidget {
  /// Card used for the home screen.
  const HomeCard({Key? key, required this.onTap, required this.title, required this.icon}) : super(key: key);

  /// On tap callback.
  final Function() onTap;

  /// Title of the card.
  final String title;

  /// Icon of the card.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: OffsetOnHover(
        duration: FluentTheme.of(context).fastAnimationDuration,
        curve: FluentTheme.of(context).animationCurve,
        offset: Offset(0, -5),
        child: SizedBox(
          width: 250,
          height: 300,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 60),
                NcSpacing.medium(),
                NcBodyText(
                  title,
                  fontSize: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

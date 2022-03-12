import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/view/widgets/info_box_container.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_ui/utils.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key, required this.onTap, required this.title, required this.icon}) : super(key: key);

  final Function() onTap;
  final String title;
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

import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/view/widgets/info_box_container.dart';
import 'package:nekolib_ui/core.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key, required this.onTap, required this.title, required this.icon}) : super(key: key);

  final Function() onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 250,
          height: 300,
          decoration: InfoBoxContainer.decoration(),
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
    );
  }
}

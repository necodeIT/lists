import 'package:fluent_ui/fluent_ui.dart';
import 'package:nekolib_ui/core.dart';

class Lists extends StatefulWidget {
  const Lists({Key? key}) : super(key: key);

  static const String route = '/lists';

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryColor,
    );
  }
}

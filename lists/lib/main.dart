import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/home/home.dart';
import 'package:nekolib_ui/core.dart';

void main() {
  runThemedApp((context) => App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Lists',
      home: Home(),
    );
  }
}

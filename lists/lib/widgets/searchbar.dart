import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/helpers/styles/styles.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({Key? key, required this.onQuery, this.placeholder = "Search..."}) : super(key: key);

  final Function(String) onQuery;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextBox(
        style: textStyle(),
        placeholderStyle: placeholderStyle(),
        placeholder: placeholder,
        suffix: Icon(FluentIcons.search),
        onChanged: onQuery,
      ),
    );
  }
}

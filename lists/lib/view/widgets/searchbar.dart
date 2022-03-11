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
        padding: EdgeInsets.all(4),
        style: textBoxTextStyle(),
        placeholderStyle: textBoxPlaceholderStyle(),
        placeholder: placeholder,
        suffix: Icon(FluentIcons.ic_fluent_search_24_filled, size: 15),
        onChanged: onQuery,
      ),
    );
  }
}

import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/db/collection.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:nekolib_ui/core.dart';

class CreateNewEntryDialog extends StatefulWidget {
  const CreateNewEntryDialog({Key? key, required this.onCreate, required this.collection}) : super(key: key);

  final Function(String, String) onCreate;
  final Collection collection;

  @override
  State<CreateNewEntryDialog> createState() => _CreateNewEntryDialogState();
}

class _CreateNewEntryDialogState extends State<CreateNewEntryDialog> {
  final _keyController = TextEditingController();
  final _valueController = TextEditingController();

  bool _validateInput() {
    if (_keyController.text.isEmpty) {
      showAlertDialog(context, "Invalid input", "Key cannot be empty");
      return false;
    }

    if (_valueController.text.isEmpty) {
      showAlertDialog(context, "Invalid input", "Value cannot be empty");
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: NcTitleText("Add new entry to ${widget.collection.name}"),
      content: Column(
        children: [
          TextBox(
            placeholder: "Key",
            style: textStyle(),
            placeholderStyle: placeholderStyle(),
            controller: _keyController,
          ),
          NcSpacing.large(),
          TextBox(
            placeholder: "Value",
            style: textStyle(),
            placeholderStyle: placeholderStyle(),
            controller: _valueController,
          ),
        ],
      ),
      actions: [
        FilledButton(
          child: NcTitleText(
            "Add entry",
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            if (!_validateInput()) return;

            widget.onCreate(_keyController.text, _valueController.text);
          },
        ),
        Button(
          child: NcTitleText(
            "Cancel",
            textAlign: TextAlign.center,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      style: contentDialogStyle(),
    );
  }
}

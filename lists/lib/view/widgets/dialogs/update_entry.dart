import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/models/collection.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/view/styles/styles.dart';
import 'package:nekolib_ui/core.dart';

/// Dialog to edit a list entry.
class UpdateEntryDialog extends StatefulWidget {
  /// Dialog to edit a list entry.
  const UpdateEntryDialog({Key? key, required this.onUpdate, required this.collection, required this.entry}) : super(key: key);

  /// Callback when the list entry is updated.
  final Function(String, String) onUpdate;

  /// The key of the entry to edit.
  final String entry;

  /// Collection to edit the list entry in.
  final Collection collection;

  @override
  State<UpdateEntryDialog> createState() => _UpdateEntryDialog();
}

class _UpdateEntryDialog extends State<UpdateEntryDialog> {
  late final TextEditingController _keyController;
  late final TextEditingController _valueController;

  bool _validateInput() {
    if (_keyController.text.isEmpty) {
      showAlertDialog(context, "Invalid parameters", "Key cannot be empty!");
      return false;
    }

    if (_valueController.text.isEmpty) {
      showAlertDialog(context, "Invalid parameters", "Value cannot be empty!");
      return false;
    }

    if (_keyController.text != widget.entry && widget.collection.entries.keys.toList().contains(_keyController.text)) {
      showAlertDialog(context, "Invalid parameters", "Entry with this key already exists!");
      return false;
    }

    return true;
  }

  @override
  void initState() {
    _keyController = TextEditingController(text: widget.entry);
    _valueController = TextEditingController(text: widget.collection[widget.entry]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: NcTitleText('Edit ${widget.entry}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextBox(
            placeholder: 'Enter key',
            autofocus: true,
            style: textBoxTextStyle(),
            placeholderStyle: textBoxPlaceholderStyle(),
            controller: _keyController,
          ),
          NcSpacing.large(),
          TextBox(
            placeholder: 'Enter value',
            controller: _valueController,
            style: textBoxTextStyle(),
            placeholderStyle: textBoxPlaceholderStyle(),
          ),
        ],
      ),
      actions: [
        FilledButton(
          child: NcTitleText(
            'Update entry',
            textAlign: TextAlign.center,
            buttonText: true,
          ),
          style: filledButtonStyle(),
          onPressed: () {
            if (!_validateInput()) return;
            widget.onUpdate(_keyController.text, _valueController.text);
          },
        ),
        Button(
          child: NcTitleText(
            'Cancel',
            textAlign: TextAlign.center,
          ),
          onPressed: Navigator.of(context).pop,
        ),
      ],
      style: contentDialogStyle(),
    );
  }
}

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:lists/widgets/tooltip_icon_button.dart';
import 'package:mime/mime.dart';
import 'package:nekolib_ui/core.dart';

class CreateNewListDialog extends StatefulWidget {
  const CreateNewListDialog({Key? key, required this.onCreate}) : super(key: key);

  final Function(String, String, String) onCreate;

  @override
  State<CreateNewListDialog> createState() => _CreateNewListDialogState();
}

class _CreateNewListDialogState extends State<CreateNewListDialog> {
  String _name = "";
  String _password = "";
  String _repeatPassword = "";
  final TextEditingController _imagePathController = TextEditingController();

  bool _enablePassword = false;

  _updateEnablePassword(bool? value) {
    setState(() {
      _enablePassword = value ?? false;
    });
  }

  _updateName(String value) {
    setState(() {
      _name = value;
    });
  }

  _updatePassword(String value) {
    setState(() {
      _password = value;
    });
  }

  _updateRepeatPassword(String value) {
    setState(() {
      _repeatPassword = value;
    });
  }

  Future _borwseImage() async {
    var f = await FilePicker.platform.pickFiles(
      dialogTitle: "Pick icon image for $_name",
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (f == null) return;

    // _imagePathController.value = TextEditingValue(text: f.files.first.path!);
    _imagePathController.text = f.files.first.path!;
  }

  bool _validateInput() {
    if (_name.isEmpty) {
      showAlertDialog(context, "Invalid parameters", "Name cannot be empty");
      return false;
    }
    if (_enablePassword) {
      if (_password.isEmpty || _repeatPassword.isEmpty) {
        showAlertDialog(context, "Invalid parameters", "Password cannot be empty");
        return false;
      }
      if (_password != _repeatPassword) {
        showAlertDialog(context, "Invalid parameters", "Passwords do not match");
        return false;
      }
    }
    if (_imagePathController.text.isNotEmpty) {
      var f = File(_imagePathController.text);
      if (!f.existsSync()) {
        showAlertDialog(context, "Invalid parameters", "Icon image file does not exist");
        return false;
      }

      var type = lookupMimeType(f.path);

      if (type == null) {
        showAlertDialog(context, "Invalid parameters", "Icon image file is not a valid image");
        return false;
      }

      if (!type.startsWith("image/")) {
        showAlertDialog(context, "Invalid parameters", "Icon image file is not a valid image");
        return false;
      }
    }
    return true;
  }

  bool _showPassword = false;
  bool _showRepeatPassword = false;

  _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  _toggleShowRepeatPassword() {
    setState(() {
      _showRepeatPassword = !_showRepeatPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: NcTitleText('Create new list'),
      content: Column(
        children: [
          TextBox(
            placeholder: 'Enter list name',
            autofocus: true,
            style: textBoxTextStyle(),
            placeholderStyle: textBoxPlaceholderStyle(),
            onChanged: _updateName,
          ),
          NcSpacing.large(),
          TextBox(
            placeholder: 'Icon (optional)',
            controller: _imagePathController,
            style: textBoxTextStyle(),
            placeholderStyle: textBoxPlaceholderStyle(),
            suffix: TooltipIconButton(
              tooltip: "Browse",
              icon: FluentIcons.ic_fluent_folder_open_24_filled,
              color: adaptiveAccentColor,
              onPressed: _borwseImage,
            ),
          ),
          if (_enablePassword) NcSpacing.large(),
          if (_enablePassword)
            TextBox(
              placeholder: 'Enter password',
              obscureText: !_showPassword,
              onChanged: _updatePassword,
              style: textBoxTextStyle(),
              placeholderStyle: textBoxPlaceholderStyle(),
              suffix: TooltipIconButton(
                tooltip: _showPassword ? "Hide password" : "Show password",
                icon: _showPassword ? FluentIcons.ic_fluent_eye_hide_24_filled : FluentIcons.ic_fluent_eye_show_24_filled,
                color: adaptiveAccentColor,
                onPressed: _toggleShowPassword,
              ),
            ),
          if (_enablePassword) NcSpacing.large(),
          if (_enablePassword)
            TextBox(
              placeholder: 'Repeat password',
              obscureText: !_showRepeatPassword,
              style: textBoxTextStyle(),
              placeholderStyle: textBoxPlaceholderStyle(),
              onChanged: _updateRepeatPassword,
              suffix: TooltipIconButton(
                tooltip: _showRepeatPassword ? "Hide password" : "Show password",
                icon: _showRepeatPassword ? FluentIcons.ic_fluent_eye_hide_24_filled : FluentIcons.ic_fluent_eye_show_24_filled,
                color: adaptiveAccentColor,
                onPressed: _toggleShowRepeatPassword,
              ),
            ),
          NcSpacing.large(),
          Align(
            alignment: Alignment.centerRight,
            child: Checkbox(
              checked: _enablePassword,
              content: NcCaptionText("Password"),
              onChanged: _updateEnablePassword,
            ),
          ),
        ],
      ),
      actions: [
        FilledButton(
          child: NcTitleText(
            'Create list',
            textAlign: TextAlign.center,
            buttonText: true,
          ),
          style: filledButtonStyle(),
          onPressed: () {
            if (!_validateInput()) return;
            widget.onCreate(_name, _password, _imagePathController.text);
          },
        ),
        Button(
          child: NcTitleText(
            'Cancel',
            textAlign: TextAlign.center,
          ),
          style: buttonStyle(),
          onPressed: Navigator.of(context).pop,
        ),
      ],
      style: contentDialogStyle(),
    );
  }
}

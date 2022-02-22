import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:mime/mime.dart';
import 'package:nekolib_ui/core.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

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
            onChanged: _updateName,
          ),
          NcSpacing.large(),
          TextBox(
            placeholder: 'Icon (optional)',
            controller: _imagePathController,
            suffix: IconButton(
              icon: Icon(
                Icons.folder,
                color: accentColor,
              ),
              onPressed: _borwseImage,
            ),
          ),
          if (_enablePassword) NcSpacing.large(),
          if (_enablePassword)
            TextBox(
              placeholder: 'Enter password',
              obscureText: !_showPassword,
              onChanged: _updatePassword,
              suffix: TextButton(
                child: Icon(
                  _showPassword ? Ionicons.eye_off : Ionicons.eye,
                  color: accentColor,
                ),
                onPressed: _toggleShowPassword,
              ),
            ),
          if (_enablePassword) NcSpacing.large(),
          if (_enablePassword)
            TextBox(
              placeholder: 'Repeat password',
              obscureText: !_showRepeatPassword,
              onChanged: _updateRepeatPassword,
              suffix: IconButton(
                icon: Icon(
                  _showRepeatPassword ? Ionicons.eye_off : Ionicons.eye,
                  color: accentColor,
                ),
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
            'Create List',
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

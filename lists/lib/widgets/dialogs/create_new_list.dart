import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:nekolib_ui/core.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CreateNewListDialog extends StatefulWidget {
  const CreateNewListDialog({Key? key, required this.onCreate}) : super(key: key);

  final Function(String, String) onCreate;

  @override
  State<CreateNewListDialog> createState() => _CreateNewListDialogState();
}

class _CreateNewListDialogState extends State<CreateNewListDialog> {
  String _name = "";
  String _password = "";
  String _repeatPassword = "";

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

  bool _validateInput() {
    if (_name.isEmpty) {
      return false;
    }
    if (_enablePassword) {
      if (_password.isEmpty || _repeatPassword.isEmpty) {
        return false;
      }
      if (_password != _repeatPassword) {
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
              suffix: TextButton(
                child: Icon(
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
          onPressed: _validateInput() ? () => widget.onCreate(_name, _password) : null,
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

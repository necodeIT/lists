import 'dart:io';
import 'package:badges/badges.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/assets/assets.dart';
import 'package:lists/db/collection.dart';
import 'package:lists/db/db.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/helpers/styles/styles.dart';
import 'package:lists/widgets/tooltip_icon_button.dart';
import 'package:mime/mime.dart';
import 'package:nekolib_ui/core.dart';

class UpdateListDialog extends StatefulWidget {
  const UpdateListDialog({Key? key, required this.onUpdate, required this.collection, required this.password}) : super(key: key);

  final Function(String, String, String, bool) onUpdate;
  final String password;
  final Collection collection;

  @override
  State<UpdateListDialog> createState() => _UpdateListDialog();
}

class _UpdateListDialog extends State<UpdateListDialog> {
  final TextEditingController _imagePathController = TextEditingController();
  late final TextEditingController _nameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _repeatPasswordController;
  bool _changedIcon = false;

  bool _enablePassword = false;

  _updateEnablePassword(bool? value) {
    setState(() {
      _enablePassword = value ?? false;
    });
  }

  Future _borwseImage() async {
    var f = await FilePicker.platform.pickFiles(
      dialogTitle: "Pick icon image for ${_nameController.text}",
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (f == null) return;

    // _imagePathController.value = TextEditingValue(text: f.files.first.path!);
    _imagePathController.text = f.files.first.path!;
  }

  bool _validateInput() {
    if (_nameController.text.isEmpty) {
      showAlertDialog(context, "Invalid parameters", "Name cannot be empty!");
      return false;
    }
    if (_enablePassword) {
      if (_passwordController.text.isEmpty || _repeatPasswordController.text.isEmpty) {
        showAlertDialog(context, "Invalid parameters", "Password cannot be empty!");
        return false;
      }
      if (_passwordController.text != _repeatPasswordController.text) {
        showAlertDialog(context, "Invalid parameters", "Passwords do not match!");
        return false;
      }
    }
    if (_imagePathController.text.isNotEmpty) {
      var f = File(_imagePathController.text);
      if (!f.existsSync()) {
        showAlertDialog(context, "Invalid parameters", "Icon image file does not exist!");
        return false;
      }

      var type = lookupMimeType(f.path);

      if (type == null) {
        showAlertDialog(context, "Invalid parameters", "Icon image file is not a valid image!");
        return false;
      }

      if (!type.startsWith("image/")) {
        showAlertDialog(context, "Invalid parameters", "Icon image file is not a valid image!");
        return false;
      }
    }

    if (_nameController.text != widget.collection.name && DB.collectionNames.contains(_nameController.text)) {
      showAlertDialog(context, "Invalid parameters", "List with this name already exists!");
      return false;
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

  _changeIcon() {
    setState(() {
      _changedIcon = true;
    });
  }

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.collection.name);
    _passwordController = TextEditingController(text: widget.password);
    _repeatPasswordController = TextEditingController(text: widget.password);
    _enablePassword = widget.password.isNotEmpty;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: NcTitleText('Edit ${widget.collection.name}'),
      content: Column(
        children: [
          if (!_changedIcon) NcSpacing.large(),
          if (!_changedIcon)
            Badge(
              padding: EdgeInsets.zero,
              child: widget.collection.hasIcon
                  ? Image.memory(
                      widget.collection.icon,
                      height: 100,
                      width: 100,
                    )
                  : Image.asset(
                      img_default_list_icon,
                      color: textColor,
                      height: 100,
                      width: 100,
                    ),
              badgeContent: TooltipIconButton(
                tooltip: 'Change icon',
                icon: FluentIcons.ic_fluent_archive_24_filled,
                onPressed: _changeIcon,
                size: 12,
              ),
            ),
          if (!_changedIcon) NcSpacing.large(),
          TextBox(
            placeholder: 'Enter list name',
            autofocus: true,
            style: textBoxTextStyle(),
            placeholderStyle: textBoxPlaceholderStyle(),
            controller: _nameController,
          ),
          if (_changedIcon) NcSpacing.large(),
          if (_changedIcon)
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
              controller: _passwordController,
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
              controller: _repeatPasswordController,
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
            'Update list',
            textAlign: TextAlign.center,
            buttonText: true,
          ),
          style: filledButtonStyle(),
          onPressed: () {
            if (!_validateInput()) return;
            widget.onUpdate(_nameController.text, _enablePassword ? _passwordController.text : "", _imagePathController.text, _changedIcon);
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

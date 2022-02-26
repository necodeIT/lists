import 'dart:io';
import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/db/collection.dart';
import 'package:lists/db/db.dart';
import 'package:lists/routes/list/list.dart';
import 'package:lists/routes/lists/lists.dart';
import 'package:lists/widgets/dialogs/alert.dart';
import 'package:lists/widgets/dialogs/confirm_dialog.dart';
import 'package:lists/widgets/dialogs/create_new_list.dart';
import 'package:lists/widgets/dialogs/new_entry.dart';
import 'package:lists/widgets/dialogs/password_dialog.dart';
import 'package:lists/widgets/dialogs/settings_dialog.dart';

showCreateNewListDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => CreateNewListDialog(
      onCreate: (name, password, imgPath) => _createNewList(context, name, password, imgPath),
    ),
  );
}

showConfirmDialog({required BuildContext context, required String title, String? message, required Function onConfirm, Function? onCancel, String confirmText = "Confirm", String cancelText = "Cancel"}) {
  showDialog(
    context: context,
    builder: (context) => ConfirmDialog(
      title: title,
      message: message,
      onConfirm: onConfirm,
      onCancel: onCancel,
      confirmText: confirmText,
      cancelText: cancelText,
    ),
  );
}

_createNewList(BuildContext context, String name, String password, String imgPath) async {
  var img = Uint8List(0);
  var f = File(imgPath);
  if (f.existsSync()) {
    img = await f.readAsBytes();
  }

  if (!DB.createNewCollection(name, password, img)) {
    showAlertDialog(context, "Error", "List with this name already exists!");
    return;
  }

  Navigator.of(context).pop();
  Navigator.of(context).pushNamed(ListsRoute.routeName);
}

showAlertDialog(BuildContext context, String title, String message) => showDialog(context: context, builder: (context) => AlertDialog(title: title, message: message));

showCreateNewEntryDialog(BuildContext context, String password, Collection collection) {
  showDialog(
    context: context,
    builder: (context) => CreateNewEntryDialog(
      collection: collection,
      onCreate: (key, value) => _addEntry(context, password, key, value, collection),
    ),
  );
}

_addEntry(BuildContext context, String password, String key, String value, Collection collection) async {
  if (!await collection.addEntry(password, key, value)) {
    showAlertDialog(context, "Error", "Entry with this key already exists!");
    return;
  }

  Navigator.of(context).pop();
  Navigator.of(context).pushNamed(
    ListRoute.routeName,
    arguments: {
      "collection": collection,
      "password": password,
    },
  );
}

showPasswordDialog(BuildContext context, Collection collection, [Function(BuildContext, Collection, String)? onPasswordEntered]) {
  Function callback = onPasswordEntered ?? _checkPassword;
  if (!collection.isProtected) return callback(context, collection, "");

  showDialog(
    context: context,
    builder: (context) => PasswordDialog(
      collection: collection,
      onConfirm: (password) => callback(context, collection, password),
    ),
  );
}

_checkPassword(BuildContext context, Collection collection, String password) async {
  if (!await collection.checkPassword(password)) {
    showAlertDialog(context, "Access denied", "Wrong password!");
    return;
  }
  await collection.load(password);
  Navigator.of(context).pop();
  Navigator.of(context).pushNamed(ListRoute.routeName, arguments: {
    "collection": collection,
    "password": password,
  });
}

showSettingsDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => SettingsDialog());
}

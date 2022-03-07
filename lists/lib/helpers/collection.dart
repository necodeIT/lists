import 'dart:io';
import 'dart:typed_data';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/db/collection.dart';
import 'package:lists/db/db.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/routes/home/home.dart';
import 'package:lists/routes/list/list.dart';
import 'package:lists/routes/lists/lists.dart';
import 'package:lists/widgets/dialogs/update_entry.dart';
import 'package:lists/widgets/dialogs/update_list.dart';

deleteCollection(BuildContext context, Collection collection) {
  showConfirmDialog(
    context: context,
    title: "Delete ${collection.name}",
    message: "Are you sure you want to delete ${collection.name}?\nThis action cannot be undone.",
    confirmText: "Delete",
    onConfirm: () => _deleteCollection(context, collection),
  );
}

removeEntry(BuildContext context, String password, Collection collection, String key) {
  showConfirmDialog(
    context: context,
    title: "Delete $key",
    message: "Are you sure you want to delete $key?\nThis action cannot be undone.",
    confirmText: "Delete",
    onConfirm: () => _removeEntry(context, password, collection, key),
  );
}

_removeEntry(BuildContext context, String password, Collection collection, String key) async {
  await collection.removeEntry(password, key);

  Navigator.pop(context);
  Navigator.of(context).pushNamed(ListRoute.routeName, arguments: {
    "collection": collection,
    "password": password,
  });
}

editEntry(BuildContext context, String password, Collection collection, String key) {
  showDialog(
    context: context,
    builder: (context) => UpdateEntryDialog(
      collection: collection,
      entry: key,
      onUpdate: (newKey, newValue) => _updateEntry(context, password, collection, key, newKey, newValue),
    ),
  );
}

_updateEntry(BuildContext context, String password, Collection collection, String oldKey, String newKey, String value) async {
  await collection.updateEntry(password, oldKey, newKey, value);

  Navigator.pop(context);
  Navigator.of(context).pushNamed(ListRoute.routeName, arguments: {
    "collection": collection,
    "password": password,
  });
}

updateCollection(BuildContext context, Collection collection) {
  if (!collection.isProtected) return _showUpdateDialog(context, "", collection);

  showPasswordDialog(context, collection, (context, collection, password) => _showUpdateDialog(context, password, collection));
}

_showUpdateDialog(BuildContext context, String password, Collection collection) async {
  if (!await collection.checkPassword(password)) {
    showAlertDialog(context, "Access denied", "Wrong password!");
    return;
  }

  if (collection.isProtected) Navigator.of(context).pop();

  showDialog(
    context: context,
    builder: (context) => UpdateListDialog(
      onUpdate: (name, newPassword, iconPath, changedIcon) => _updateCollection(context, password, collection, newPassword, name, iconPath, changedIcon),
      collection: collection,
      password: password,
    ),
  );
}

_updateCollection(BuildContext context, String password, Collection collection, String newPassword, String newName, String newIconPath, bool changedIcon) async {
  Uint8List icon = collection.icon;

  if (changedIcon) {
    if (newIconPath.isEmpty) {
      icon = Uint8List.fromList([]);
    } else {
      icon = File(newIconPath).readAsBytesSync();
    }
  }

  await collection.update(
    newName: newName,
    icon: icon,
    password: password,
    newPassword: newPassword,
  );

  Navigator.of(context).pop();
  Navigator.of(context).pushNamed(ListsRoute.routeName);
}

_deleteCollection(BuildContext context, Collection collection) async {
  await DB.deleteCollection(collection);

  Navigator.of(context).pop();
  Navigator.of(context).pushNamed(DB.collections.isNotEmpty ? ListsRoute.routeName : HomeRoute.routeName);
}

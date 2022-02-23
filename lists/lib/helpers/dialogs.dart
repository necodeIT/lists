import 'dart:io';
import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/db/collection.dart';
import 'package:lists/db/db.dart';
import 'package:lists/routes/list/list.dart';
import 'package:lists/routes/lists/lists.dart';
import 'package:lists/widgets/dialogs/alert.dart';
import 'package:lists/widgets/dialogs/create_new_list.dart';
import 'package:lists/widgets/dialogs/new_entry.dart';
import 'package:nekolib_ui/core.dart';

showCreateNewListDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => CreateNewListDialog(
      onCreate: (name, password, imgPath) => _createNewList(context, name, password, imgPath),
    ),
  );
}

_createNewList(BuildContext context, String name, String password, String imgPath) {
  var img = imgPath.isNotEmpty ? File(imgPath).readAsBytesSync() : Uint8List(0);
  if (!DB.createNewCollection(name, password, img)) {
    showAlertDialog(context, "Error", "List with this name already exists!");
    return;
  }

  Navigator.of(context).pop();
  Navigator.of(context).pushNamed(ListsRoute.routeName);
}

showAlertDialog(BuildContext context, String title, String message) => showDialog(context: context, builder: (context) => AlertDialog(title: title, message: message));

showCreateNewEntryDialog(BuildContext context, Collection collection) {
  showDialog(
    context: context,
    builder: (context) => CreateNewEntryDialog(
      collection: collection,
      onCreate: (key, value) => _addEntry(context, key, value, collection),
    ),
  );
}

_addEntry(BuildContext context, String key, String value, Collection collection) {
  if (!collection.addEntry(key, value)) {
    showAlertDialog(context, "Error", "Entry with this key already exists!");
    return;
  }

  Navigator.of(context).pop();
  Navigator.of(context).pushNamed(ListRoute.routeName, arguments: collection);
}

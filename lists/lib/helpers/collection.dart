import 'package:flutter/widgets.dart';
import 'package:lists/db/collection.dart';
import 'package:lists/db/db.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/routes/home/home.dart';
import 'package:lists/routes/lists/lists.dart';

deleteCollection(BuildContext context, Collection collection) {
  showConfirmDialog(
    context: context,
    title: "Delete ${collection.name}",
    message: "Are you sure you want to delete ${collection.name}?\nThis action cannot be undone.",
    confirmText: "Delete",
    onConfirm: () => _deleteCollection(context, collection),
  );
}

_deleteCollection(BuildContext context, Collection collection) async {
  await DB.deleteCollection(collection);

  Navigator.of(context).pop();
  Navigator.of(context).pushNamed(DB.collections.isNotEmpty ? ListsRoute.routeName : HomeRoute.routeName);
}

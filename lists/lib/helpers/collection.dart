import 'package:flutter/widgets.dart';
import 'package:lists/db/collection.dart';
import 'package:lists/db/db.dart';
import 'package:lists/helpers/dialogs.dart';
import 'package:lists/routes/home/home.dart';
import 'package:lists/routes/lists/lists.dart';

deleteCollection(BuildContext context, Collection collection) {
  showPasswordDialog(context, collection, _deleteCollection);
}

_deleteCollection(BuildContext context, Collection collection, String password) async {
  if (collection.isProtected && !await collection.checkPassword(password)) {
    showAlertDialog(context, "Access denied", "Could not delete ${collection.name}: Wrong password!");
    return;
  }

  await DB.deleteCollection(collection);

  Navigator.of(context).pop();
  Navigator.of(context).pushNamed(DB.collections.isNotEmpty ? ListsRoute.routeName : HomeRoute.routeName);
}

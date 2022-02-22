import 'package:fluent_ui/fluent_ui.dart';
import 'package:lists/db/db.dart';
import 'package:lists/routes/lists/lists.dart';
import 'package:lists/widgets/dialogs/alert.dart';
import 'package:lists/widgets/dialogs/create_new_list.dart';
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
  if (!DB.createNewCollection(name, password, imgPath)) {
    showAlertDialog(context, "Error", "List with this name already exists!");
    return;
  }

  Navigator.of(context).pop();
  Navigator.of(context).pushNamed(ListsRoute.routeName);
}

showAlertDialog(BuildContext context, String title, String message) => showDialog(context: context, builder: (context) => AlertDialog(title: title, message: message));

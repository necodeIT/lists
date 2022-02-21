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
      onCreate: (name, password) => _createNewList(context, name, password),
    ),
  );
}

_createNewList(BuildContext context, String name, String password) {
  if (DB.createNewCollection(name, password)) {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(Lists.route);
  }

  showDialog(context: context, builder: (context) => AlertDialog(title: "Error", message: "List with this name already exists!"));
}

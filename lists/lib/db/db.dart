import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:lists/db/collection.dart';
import 'package:lists/db/updater.dart';
import 'package:lists/helpers/crypto.dart';
import 'package:path_provider/path_provider.dart';

class DB {
  static final Map<String, Collection> _collectionsMap = {};
  static final List<Collection> _collections = [];

  static List<Collection> get collections => List.unmodifiable(_collections);

  static Future<Directory> get appDir async {
    var dir = await getApplicationDocumentsDirectory();
    var path = '${dir.path}/${Updater.appName}';
    var appDir = Directory(path);
    await appDir.create();
    return appDir;
  }

  static Future<File> getCollectionFile(Collection collection) async {
    var dir = await appDir;
    var name = sha256Hash(collection.name);

    return File('${dir.path}/$name.json');
  }

  static Future<File> get settingsFile async {
    var dir = await appDir;
    return File('${dir.path}/settings.json');
  }

  static Future<File> get collectionsFile async {
    var dir = await appDir;
    return File('${dir.path}/collections.json');
  }

  static Future save() async {
    var collectionsFile = await DB.collectionsFile;

    await collectionsFile.writeAsString(jsonEncode(_collections));

    for (var col in _collections) await col.save();
  }

  static Future load() async {
    var f = await collectionsFile;

    if (!await f.exists()) return;

    try {
      List collections = jsonDecode(await f.readAsString());

      for (var collection in collections) {
        _collections.add(Collection.fromJson(collection));
      }
    } catch (e) {
      // TODO: log error
      print(e);
      return;
    }

    update(silent: true);
  }

  static bool createNewCollection(String name, String password, Uint8List icon) {
    if (_collectionsMap.containsKey(name)) return false;

    _collections.add(Collection(name, sha256Hash(password), icon));

    update();

    return true;
  }

  static void update({bool silent = false}) {
    _collectionsMap.clear();

    for (var collection in _collections) {
      _collectionsMap[collection.name] = collection;
    }

    if (!silent) save();
  }
}

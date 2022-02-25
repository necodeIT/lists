import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:lists/db/collection.dart';
import 'package:lists/db/updater.dart';
import 'package:lists/helpers/crypto.dart';
import 'package:path_provider/path_provider.dart';

class DB {
  static const fileExtention = ".json";
  static const cacheFileName = 'cache';
  static const collectionsFileName = 'collections';
  static const settingsFileName = "settings";
  static const fileNames = [cacheFileName, collectionsFileName, settingsFileName];

  static final Map<String, Collection> _collectionsMap = {};
  static final List<Collection> _collections = [];
  static bool _cleanUp = false;
  static List<Collection> get collections => List.unmodifiable(_collections);

  static Future<Directory> get appDir async {
    var dir = await getApplicationDocumentsDirectory();

    var path = '${dir.path}/${Updater.appName}';
    var appDir = Directory(path);

    await appDir.create();

    return appDir;
  }

  static Future<File> getCollectionFile(Collection collection) => _getCollectionFile(collection.name);

  static Future<File> _getCollectionFile(String collection) async {
    var dir = await appDir;
    var name = sha256Hash(collection);

    return File('${dir.path}/$name.$fileExtention');
  }

  static Future<File> get settingsFile async {
    var dir = await appDir;
    return File('${dir.path}/$settingsFileName.$fileExtention');
  }

  static Future<File> get collectionsFile async {
    var dir = await appDir;
    return File('${dir.path}/$collectionsFileName.$fileExtention');
  }

  static Future<File> get cacheFile async {
    var dir = await appDir;
    return File('${dir.path}/$cacheFileName.$fileExtention');
  }

  static Future save() async {
    var collectionsFile = await DB.collectionsFile;
    var cacheFile = await DB.cacheFile;

    var cache = {
      "cleanup": _cleanUp,
    };

    await collectionsFile.writeAsString(jsonEncode(_collections));
    await cacheFile.writeAsString(jsonEncode(cache));
  }

  static Future load() async {
    var f = await collectionsFile;
    var cacheFile = await DB.cacheFile;

    if (!await f.exists()) return;

    var content = await f.readAsString();

    if (content.isEmpty) return;

    List collections = jsonDecode(content);

    for (var collection in collections) {
      _collections.add(Collection.fromJson(collection));
    }

    update(silent: true);

    // Clean up deleted collection files

    if (!await cacheFile.exists()) return;

    content = await cacheFile.readAsString();

    if (content.isEmpty) return;

    var json = jsonDecode(content);

    _cleanUp = json["cleanup"];

    if (!_cleanUp) return;

    var keys = _collectionsMap.keys.map((e) => sha256Hash(e)).toList();

    var dir = await appDir;
    var files = await dir.list().toList();

    for (var file in files) {
      if (!file.path.endsWith(fileExtention)) continue;

      var name = file.uri.pathSegments.last.split('.').first;

      if (fileNames.contains(name)) continue;

      if (!keys.contains(name)) await file.delete();
    }

    _cleanUp = false;
  }

  static bool createNewCollection(String name, String password, Uint8List icon) {
    if (_collectionsMap.containsKey(name)) return false;

    var collection = Collection(name, password.isNotEmpty, icon);

    _collections.add(collection);
    collection.save(password);

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

  static Future<void> deleteCollection(Collection collection) async {
    var f = await getCollectionFile(collection);

    // Sometimes exceptions occur when deleting files
    // Dunno why, but it's not a big deal as we can clean up on next boot
    try {
      if (await f.exists()) {
        await f.delete();
      }
    } catch (e) {
      _cleanUp = true; // Flag for cleanup next boot
    }

    _collections.remove(collection);
    update();
  }
}

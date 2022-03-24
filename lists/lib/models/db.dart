import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:lists/models/collection.dart';
import 'package:lists/models/updater.dart';
import 'package:lists/helpers/string.dart';
import 'package:path_provider/path_provider.dart';

/// Contains and manages all the data used by the app.
class DB {
  /// The file extension used for every file saved by this app.
  static const fileExtention = ".json";

  /// The name of the app's cache file.
  static const cacheFileName = 'cache';

  /// The name of the app's collections file.
  static const collectionsFileName = 'collections';

  /// The name of the app's settings file.
  static const settingsFileName = "settings";

  /// Contains every file names needed by the database.
  static const fileNames = [cacheFileName, collectionsFileName, settingsFileName];

  static final Map<String, Collection> _collectionsMap = {};
  static final List<Collection> _collections = [];
  static bool _cleanUp = false;

  /// Every collection in the database.
  static List<Collection> get collections => List.unmodifiable(_collections);

  /// Every name of the collections in the database.
  static List<String> get collectionNames => _collectionsMap.keys.toList();

  /// Returns the collection with the given [name].
  static Collection getCollection(String name) => _collectionsMap[name]!;

  /// The app's directory to store the data in.
  static Future<Directory> get appDir async {
    var dir = await getApplicationDocumentsDirectory();

    var path = '${dir.path}/${Updater.appName}';
    var appDir = Directory(path);

    await appDir.create();

    return appDir;
  }

  /// Returns a file of the given [collection].
  static Future<File> getCollectionFile(Collection collection) async {
    var dir = await appDir;
    var name = collection.name.sha256();

    return File('${dir.path}/$name$fileExtention');
  }

  /// The settings file.
  static Future<File> get settingsFile async {
    var dir = await appDir;
    return File('${dir.path}/$settingsFileName$fileExtention');
  }

  /// The file where the user's collections are stored.
  static Future<File> get collectionsFile async {
    var dir = await appDir;
    return File('${dir.path}/$collectionsFileName$fileExtention');
  }

  /// The cache file.
  static Future<File> get cacheFile async {
    var dir = await appDir;
    return File('${dir.path}/$cacheFileName.$fileExtention');
  }

  /// Saves the database to disk.
  static Future save() async {
    var collectionsFile = await DB.collectionsFile;
    var cacheFile = await DB.cacheFile;

    var cache = {
      "cleanup": _cleanUp,
    };

    await collectionsFile.writeAsString(jsonEncode(_collections));
    await cacheFile.writeAsString(jsonEncode(cache));
  }

  /// Loads the database from disk.
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

    var keys = _collectionsMap.keys.map((e) => e.sha256()).toList();

    var dir = await appDir;
    var files = await dir.list().toList();

    for (var file in files) {
      if (!file.path.endsWith(fileExtention)) continue;

      var name = file.uri.pathSegments.last.split('.').first;

      if (fileNames.contains(name)) continue;

      if (!keys.contains(name)) await file.delete();
    }

    _cleanUp = false;
    save();
  }

  /// Marks the database as needing to be cleaned up.
  /// If this is called, the database will be cleaned up on the next load.
  static void cleanUp() {
    if (_cleanUp) return;

    _cleanUp = true;
    save();
  }

  /// Creates a new collection with the given [name].
  static bool createNewCollection(String name, String password, Uint8List icon) {
    if (_collectionsMap.containsKey(name)) return false;

    var collection = Collection(name, password.isNotEmpty, icon);

    _collections.add(collection);
    collection.save(password);

    update();

    return true;
  }

  /// Updates the database.
  static Future<void> update({bool silent = false}) async {
    _collectionsMap.clear();

    for (var collection in _collections) {
      _collectionsMap[collection.name] = collection;
    }

    if (!silent) await save();
  }

  /// Deletes the given [collection].
  static Future<void> deleteCollection(Collection collection) async {
    var f = await getCollectionFile(collection);

    // Sometimes exceptions occur when deleting files
    // Dunno why, but it's not a big deal as we can clean up on next boot
    try {
      if (await f.exists()) await f.delete();
    } catch (e) {
      cleanUp();
    }

    _collections.remove(collection);
    update();
  }
}

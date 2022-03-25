import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
// ignore: import_of_legacy_library_into_null_safe
import 'package:aes_crypt/aes_crypt.dart';
import 'package:lists/models/db.dart';
import 'package:lists/helpers/string.dart';
import 'package:nekolib_utils/log.dart';

/// A collection.
/// A collection is a map of entries.
/// It can be saved to disk and loaded from disk.
/// All collections can be password protected, in which case the file is encrypted using AesCrypt.
class Collection {
  late final Map<String, String> _entries;
  late String _name;
  late bool _protected;
  late Uint8List _icon;
  int _length = 0;
  bool _loaded = false;

  /// The name of the collection.
  String get name => _name;

  /// Whether the collection is loaded.
  bool get loaded => _loaded;

  /// The icon of the collection.
  Uint8List get icon => _icon;

  /// Creates a new collection.
  Collection(String name, bool password, Uint8List icon) {
    _protected = password;
    _icon = icon;
    _name = name;
    _entries = {};
  }

  /// The keys of the collection.
  List<String> get keys => _entries.keys.toList();

  /// The values of the collection.
  List<String> get values => _entries.keys.toList();

  /// A map of the entries of the collection.
  Map<String, String> get entries => _entries;

  /// The number of entries in the collection.
  int get length => _entries.isEmpty ? _length : _entries.length;

  /// Takes a key and returns the value of the entry with that key.
  operator [](String key) => _entries[key];

  /// Loads a collection from the given [json].
  Collection.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _protected = json["protected"] ?? json['password'];
    _icon = Uint8List.fromList(json['icon']?.cast<int>() ?? []);
    _entries = {};
    _length = json['length'] ?? 0;
  }

  /// Returns a json representation of the collection.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'protected': _protected,
      'icon': _icon,
      'length': _length,
    };
  }

  /// Tries to load the collection with the given [password].
  Future<bool> load(String password) async {
    log("[$name]: loading", LogTypes.tracking);

    if (_loaded) return true;
    if (!await checkPassword(password)) return false;

    password = password.sha256();
    var f = await DB.getCollectionFile(this);

    var crypt = AesCrypt(password);
    var data = await crypt.decryptTextFromFile(f.path);

    _entries.clear();
    _entries.addAll(jsonDecode(data).cast<String, String>());
    _loaded = true;
    return true;
  }

  /// Clears the collection.
  void dispose() {
    if (!_loaded) return;
    log("[$name]: disposed", LogTypes.tracking);

    _entries.clear();
    _loaded = false;
  }

  /// Saves the collection to disk.
  Future save(String password) async {
    password = password.sha256();
    var crypt = AesCrypt(password);
    crypt.setOverwriteMode(AesCryptOwMode.on);

    var data = jsonEncode(_entries);

    var f = await DB.getCollectionFile(this);
    await crypt.encryptTextToFile(data, f.path);
  }

  /// Whether the collection is password protected.
  bool get isProtected => _protected;

  /// Whether the collection has a custom icon.
  bool get hasIcon => _icon.isNotEmpty;

  /// Checks whether the given [password] is correct.
  Future<bool> checkPassword(String password) async {
    var f = await DB.getCollectionFile(this);

    try {
      var aes = AesCrypt(password.sha256());

      await aes.decryptDataFromFile(f.path);

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Updates the collection.
  Future<bool> update({required String password, Uint8List? icon, String? newPassword, String? newName}) async {
    if (!await checkPassword(password)) return false;
    await load(password);

    password = newPassword ?? password;
    _protected = password.isNotEmpty;

    var f = await DB.getCollectionFile(this);

    _name = newName ?? _name;

    _icon = icon ?? _icon;

    try {
      if (await f.exists()) await f.delete();
    } catch (e) {
      DB.cleanUp();
    }

    await _notifiyDB(password);

    return true;
  }

  Future<void> _notifiyDB(String password) async {
    await save(password);
    await DB.update();
  }

  /// Adds a new entry to the collection.
  Future<bool> addEntry(String password, String key, String value) async {
    if (_entries.containsKey(key)) return false;

    _entries[key] = value;
    _length = _entries.length;

    await _notifiyDB(password);

    return true;
  }

  /// Removes an entry from the collection.
  Future<bool> removeEntry(String password, String key) async {
    if (!await checkPassword(password)) return false;
    if (!_entries.containsKey(key)) return false;

    _entries.remove(key);
    _length = _entries.length;

    await _notifiyDB(password);

    return true;
  }

  /// Updates an entry in the collection.
  Future<bool> updateEntry(String password, String oldKey, String newKey, String newValue) async {
    if (!await checkPassword(password)) return false;

    if (!_entries.containsKey(oldKey)) return false;

    await removeEntry(password, oldKey);

    return addEntry(password, newKey, newValue);
  }

  /// Exports the collection to a json file.
  Future<bool> export(String password, String path, bool enablePassword) async {
    if (!await load(password)) return false;

    try {
      if (enablePassword) {
        var f = await DB.getCollectionFile(this);
        await f.copy(path);
      } else {
        var data = jsonEncode(toJson());
        await File(path).writeAsString(data);
      }
    } catch (e) {
      return false;
    }

    dispose();
    return true;
  }
}

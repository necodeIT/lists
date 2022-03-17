import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:aes_crypt/aes_crypt.dart';
import 'package:lists/models/db.dart';
import 'package:lists/helpers/string.dart';

class Collection {
  late final Map<String, String> _entries;
  late String _name;
  late bool _protected;
  late Uint8List _icon;
  int _length = 0;
  bool _loaded = false;

  String get name => _name;
  bool get loaded => _loaded;
  Uint8List get icon => _icon;

  Collection(String name, bool password, Uint8List icon) {
    _protected = password;
    _icon = icon;
    _name = name;
    _entries = {};
  }

  List<String> get keys => _entries.keys.toList();
  List<String> get values => _entries.keys.toList();
  Map<String, String> get entries => _entries;
  int get length => _entries.isEmpty ? _length : _entries.length;

  operator [](String key) => _entries[key];

  Collection.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _protected = json["protected"] ?? json['password'];
    _icon = Uint8List.fromList(json['icon']?.cast<int>() ?? []);
    _entries = {};
    _length = json['length'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'protected': _protected,
      'icon': _icon,
      'length': _length,
    };
  }

  Future<bool> load(String password) async {
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

  void dispose() {
    if (!_loaded) return;

    _entries.clear();
    _loaded = false;
  }

  Future save(String password) async {
    password = password.sha256();
    var crypt = AesCrypt(password);
    crypt.setOverwriteMode(AesCryptOwMode.on);

    var data = jsonEncode(_entries);

    var f = await DB.getCollectionFile(this);
    await crypt.encryptTextToFile(data, f.path);
  }

  bool get isProtected => _protected;
  bool get hasIcon => _icon.isNotEmpty;

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

  Future<bool> addEntry(String password, String key, String value) async {
    if (_entries.containsKey(key)) return false;

    _entries[key] = value;
    _length = _entries.length;

    await _notifiyDB(password);

    return true;
  }

  Future<bool> removeEntry(String password, String key) async {
    if (!await checkPassword(password)) return false;
    if (!_entries.containsKey(key)) return false;

    _entries.remove(key);
    _length = _entries.length;

    await _notifiyDB(password);

    return true;
  }

  Future<bool> updateEntry(String password, String oldKey, String newKey, String newValue) async {
    if (!await checkPassword(password)) return false;

    if (!_entries.containsKey(oldKey)) return false;

    await removeEntry(password, oldKey);

    return addEntry(password, newKey, newValue);
  }

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

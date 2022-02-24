import 'dart:convert';
import 'dart:typed_data';

import 'package:aes_crypt/aes_crypt.dart';
import 'package:crypto/crypto.dart';
import 'package:lists/db/db.dart';
import 'package:lists/helpers/crypto.dart';

class Collection {
  late final Map<String, String> _entries;
  late String _name;
  late String _password;
  late Uint8List _icon;
  int _length = 0;
  static const emptyHash = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";

  String get name => _name;
  Uint8List get icon => _icon;

  Collection(String name, String password, Uint8List icon) {
    _password = password;
    _icon = icon;
    _name = name;
    _entries = {};
  }

  List<String> get keys => _entries.keys.toList();
  List<String> get values => _entries.keys.toList();
  Iterable<MapEntry<String, String>> get entries => _entries.entries;
  int get length => _entries.isEmpty ? _length : _entries.length;

  operator [](String key) => _entries[key];

  operator []=(String key, String value) {
    if (_entries.containsKey(key) && _entries[key] == value) return;

    _entries[key] = value;
    _notifiyDB();
  }

  Collection.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _password = json['password'];
    _icon = Uint8List.fromList(json['icon']?.cast<int>() ?? []);
    _entries = {};
    _length = json['length'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': _password,
      'icon': _icon,
      'length': _length,
    };
  }

  Future load(String password) async {
    if (!checkPassword(password)) return;

    password = sha256Hash(password);
    var f = await DB.getCollectionFile(this);

    var crypt = AesCrypt(password);
    var data = await crypt.decryptTextFromFile(f.path);

    _entries.clear();
    _entries.addAll(jsonDecode(data).cast<String, String>());
  }

  void dispose() {
    _entries.clear();
  }

  Future save() async {
    var crypt = AesCrypt(_password);
    crypt.setOverwriteMode(AesCryptOwMode.on);

    var data = jsonEncode(_entries);

    var f = await DB.getCollectionFile(this);
    await crypt.encryptTextToFile(data, f.path);
  }

  bool get isPasswordProtected => _password != emptyHash;
  bool get hasIcon => _icon.isNotEmpty;

  bool checkPassword(String password) => _password == sha256Hash(password);

  bool changePassword(String oldPassword, String newPassword) {
    if (!checkPassword(oldPassword)) return false;

    _password = sha256Hash(newPassword);
    _notifiyDB();

    return true;
  }

  bool changeName(String password, String newName) {
    if (!checkPassword(password)) return false;

    DB.getCollectionFile(this).then((f) {
      if (f.existsSync()) f.deleteSync();
    });

    _name = newName;
    _notifiyDB();

    return true;
  }

  bool changeImgPath(String password, Uint8List newImgPath) {
    if (!checkPassword(password)) return false;

    _icon = newImgPath;
    _notifiyDB();

    return true;
  }

  void _notifiyDB() {
    _length = _entries.length;
    DB.update();
  }

  bool addEntry(String key, String value) {
    if (_entries.containsKey(key)) return false;

    _entries[key] = value;
    _notifiyDB();

    return true;
  }

  void removeEntry(String key) {
    if (!_entries.containsKey(key)) return;

    _entries.remove(key);
    _notifiyDB();
  }

  bool updateEntry(String oldKey, String newKey, String newValue) {
    if (!_entries.containsKey(oldKey)) return false;

    removeEntry(oldKey);

    return addEntry(newKey, newValue);
  }
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:lists/db/db.dart';

class Collection {
  late final Map<String, String> _entries;
  late String _name;
  late String _password;
  late Uint8List _icon;

  static const emptyHash = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";

  String get name => _name;
  Uint8List get icon => _icon;

  Collection(String name, String password, Uint8List icon, Map<String, String> entries) {
    _entries = Map.from(entries);
    _password = password;
    _icon = icon;
    _name = name;
  }

  List<String> get keys => _entries.keys.toList();
  List<String> get values => _entries.keys.toList();
  Iterable<MapEntry<String, String>> get entries => _entries.entries;
  int get length => _entries.length;

  operator [](String key) => _entries[key];

  operator []=(String key, String value) {
    if (_entries.containsKey(key) && _entries[key] == value) return;

    _entries[key] = value;
    _notifiyDB();
  }

  Collection.fromJson(Map<String, dynamic> json) {
    var icon = json['icon'].cast<int>();
    _name = json['name'];
    _password = json['password'];
    _entries = Map.from(json['entries']);
    _icon = Uint8List.fromList(json['icon']?.cast<int>() ?? []);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': _password,
      'entries': _entries,
      'icon': _icon,
    };
  }

  bool get requiresPassword => _password != emptyHash;
  bool get hasIcon => _icon.isNotEmpty;

  bool checkPassword(String password) => _password == hashPassword(password);

  static String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);

    return digest.toString();
  }

  bool changePassword(String oldPassword, String newPassword) {
    if (!checkPassword(oldPassword)) return false;

    _password = hashPassword(newPassword);
    _notifiyDB();

    return true;
  }

  bool changeName(String password, String newName) {
    if (!checkPassword(password)) return false;

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

  void _notifiyDB() => DB.update();

  bool addEntry(String key, String value) {
    if (_entries.containsKey(key)) return false;

    _entries[key] = value;
    _notifiyDB();

    return true;
  }
}

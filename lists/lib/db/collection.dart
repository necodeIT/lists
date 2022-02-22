import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:lists/db/db.dart';

class Collection {
  late final Map<String, String> _entries;
  late String _name;
  late String _password;
  late String _imgPath;

  String get name => _name;
  String get imgPath => _imgPath;

  Collection(String name, String password, String imgPath, Map<String, String> entries) {
    _entries = Map.from(entries);
    _password = password;
    _imgPath = imgPath;
    _name = name;
  }

  Map<String, String> get entries => Map.unmodifiable(_entries);

  operator [](String key) => _entries[key];

  operator []=(String key, String value) {
    if (_entries.containsKey(key) && _entries[key] == value) return;

    _entries[key] = value;
    _notifiyDB();
  }

  List<String> get keys => _entries.keys.toList();

  Collection.fromJson(Map<String, dynamic> json) {
    // return Collection(json['name'], json['password'], json['entries']);
    _name = json['name'];
    _password = json['password'];
    _entries = Map.from(json['entries']);
    _imgPath = json['imgPath'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': _password,
      'entries': _entries,
      'imgPath': _imgPath,
    };
  }

  bool get requiresPassword => _password.isNotEmpty;
  bool get hasIcon => _imgPath.isNotEmpty;

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

  bool changeImgPath(String password, String newImgPath) {
    if (!checkPassword(password)) return false;

    _imgPath = newImgPath;
    _notifiyDB();

    return true;
  }

  void _notifiyDB() => DB.update();
}

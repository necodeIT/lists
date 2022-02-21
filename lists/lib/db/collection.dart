import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:lists/db/db.dart';

class Collection {
  final Map<String, String> _entries;
  String name;
  String _password;

  Collection(this.name, String password, Map<String, String> entries)
      : _entries = Map.from(entries),
        _password = password;

  Map<String, String> get entries => Map.unmodifiable(_entries);

  operator [](String key) => _entries[key];

  operator []=(String key, String value) {
    if (_entries.containsKey(key) && _entries[key] == value) return;

    _entries[key] = value;
    _notifiyDB();
  }

  List<String> get keys => _entries.keys.toList();

  Collection fromJson(Map<String, dynamic> json) {
    return Collection(json['name'], json['password'], json['entries']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': _password,
      'entries': _entries,
    };
  }

  bool get requiresPassword => _password.isNotEmpty;

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

    name = newName;
    _notifiyDB();

    return true;
  }

  void _notifiyDB() => DB.update();
}

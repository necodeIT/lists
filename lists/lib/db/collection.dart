import 'dart:convert';
import 'dart:typed_data';
import 'package:aes_crypt/aes_crypt.dart';
import 'package:lists/db/db.dart';
import 'package:lists/helpers/crypto.dart';

class Collection {
  late final Map<String, String> _entries;
  late String _name;
  late bool _password;
  late Uint8List _icon;
  int _length = 0;
  bool _loaded = false;

  String get name => _name;
  bool get loaded => _loaded;
  Uint8List get icon => _icon;

  Collection(String name, bool password, Uint8List icon) {
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
    if (_loaded) return;
    if (!await checkPassword(password)) return;

    password = sha256Hash(password);
    var f = await DB.getCollectionFile(this);

    var crypt = AesCrypt(password);
    var data = await crypt.decryptTextFromFile(f.path);

    _entries.clear();
    _entries.addAll(jsonDecode(data).cast<String, String>());
    _loaded = true;
  }

  void dispose() {
    if (!_loaded) return;

    _entries.clear();
    _loaded = false;
  }

  Future save(String password) async {
    password = sha256Hash(password);
    var crypt = AesCrypt(password);
    crypt.setOverwriteMode(AesCryptOwMode.on);

    var data = jsonEncode(_entries);

    var f = await DB.getCollectionFile(this);
    await crypt.encryptTextToFile(data, f.path);
  }

  bool get isPasswordProtected => _password;
  bool get hasIcon => _icon.isNotEmpty;

  Future<bool> checkPassword(String password) async {
    var f = await DB.getCollectionFile(this);

    try {
      var aes = AesCrypt(sha256Hash(password));

      await aes.decryptDataFromFile(f.path);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    if (!await checkPassword(oldPassword)) return false;

    _notifiyDB(newPassword);

    return true;
  }

  Future<bool> changeName(String password, String newName) async {
    if (!await checkPassword(password)) return false;

    DB.getCollectionFile(this).then((f) {
      if (f.existsSync()) f.deleteSync();
    });

    _name = newName;
    _notifiyDB(password);

    return true;
  }

  Future<bool> changeImgPath(String password, Uint8List newImgPath) async {
    if (!await checkPassword(password)) return false;

    _icon = newImgPath;
    _notifiyDB(password);

    return true;
  }

  void _notifiyDB(String password) {
    save(password);
    DB.update();
  }

  Future<bool> addEntry(String password, String key, String value) async {
    if (_entries.containsKey(key)) return false;

    _entries[key] = value;
    _length = _entries.length;

    _notifiyDB(password);

    return true;
  }

  void removeEntry(String password, String key) {
    if (!_entries.containsKey(key)) return;

    _entries.remove(key);
    _length = _entries.length;

    _notifiyDB(password);
  }

  Future<bool> updateEntry(String password, String oldKey, String newKey, String newValue) async {
    if (!_entries.containsKey(oldKey)) return false;

    removeEntry(password, oldKey);

    return addEntry(password, newKey, newValue);
  }
}

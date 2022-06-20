part of lists_engine;

/// Responsible for saving and loading [Collection]s.
class CollectionDisk {
  static const emptyPassword = "";
  static Encrypter _encrypter(String password) => Encrypter(AES(Key.fromUtf8(password)));

  /// Saves a [Collection] to the disk.
  static Future<void> saveCollection(IndexLink data, String pasword) async {
    var pw = data.metaData.protected ? pasword : emptyPassword;
    var f = await data.metaData.file;

    var json = jsonEncode(data.collection);

    var encrypted = _encrypter(pw).encrypt(json);

    await f.writeAsString(encrypted.base64);
  }

  /// Loads a [Collection] from the disk.
  static Future<DecryptionResult> loadCollection(IndexLink data, String pasword) async {
    var pw = data.metaData.protected ? pasword : emptyPassword;
    var file = await data.metaData.file;

    try {
      var base64 = await file.readAsString();

      var content = _encrypter(pw).decrypt(Encrypted.fromBase64(base64));

      var json = jsonDecode(content);

      var collection = Collection.fromJson(json);

      var catgirl = data.copyWith(collection: collection);

      return DecryptionResult(catgirl, true);
    } catch (e) {
      return DecryptionResult(data, false);
    }
  }
}

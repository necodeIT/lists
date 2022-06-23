part of lists_engine;

/// Responsible for saving and loading [Collection]s.
class CollectionDisk {
  static String _pw(CollectionMetaData data, String password) => data.protected ? password : kUnprotectedPassword;

  static AesCrypt _crypt(String password) {
    var crypt = AesCrypt();

    crypt.setPassword(password);

    return crypt;
  }

  /// Saves a [Collection] to the disk.
  static Future<void> saveCollection(IndexLink data, String password) async {
    var pw = _pw(data.metaData, password);

    var f = await data.metaData.file;

    var json = jsonEncode(data.collection);

    var crypt = _crypt(pw);

    if (await f.exists()) await f.delete();

    await crypt.encryptTextToFile(
      json,
      f.path,
    );
  }

  /// Loads a [Collection] from the disk.
  static Future<DecryptionResult> loadCollection(CollectionMetaData data, String password) async {
    var pw = _pw(data, password);

    try {
      var crypt = _crypt(pw);

      var content = await crypt.decryptTextFromFile(await data.path);

      var json = jsonDecode(content);

      var collection = Collection.fromJson(json);

      var catgirl = IndexLink(collection: collection, metaData: data);

      return DecryptionResult.succeeded(catgirl);
    } catch (e) {
      return DecryptionResult.failed();
    }
  }

  /// Deletes the linked [Collection] from the disk.
  static Future<void> deleteCollection(CollectionMetaData data) async {
    var f = await data.file;

    if (await f.exists()) await f.delete();
  }
}

part of lists_engine;

/// Responsible for saving and loading the [Index] file.
class IndexDisk {
  static Index? _data;

  /// The loaded [Index] from disk.
  static Index? get data => _data;

  /// The name of the file where the [Index] is stored.
  static const String indexFileName = "index.json";

  /// The file where the [Index] is stored.
  static Future<File> get indexFile async {
    var dir = await Disk.appDir;

    var file = File('${dir.path}/$indexFileName');

    return file;
  }

  /// Saves the [index] to the disk.
  static Future<void> saveIndex(Index index) async {
    var file = await indexFile;

    var json = jsonEncode(index.values.toList());

    await file.writeAsString(json);
  }

  /// Loads the [Index] from the disk.
  static Future<void> loadIndex() async {
    var file = await indexFile;

    try {
      var json = await file.readAsString();

      var parsed = jsonDecode(json, reviver: (key, value) {
        if (key is! int) return value;
        if (value is! Map) return value;

        return CollectionMetaData.fromJson(Json.from(value));
      });

      _data = Index.fromIterable(parsed, key: (e) => e.name);
    } catch (e) {
      _data = null;
    }
  }
}

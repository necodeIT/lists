part of controllers;

/// Controller which handles the importing of lists.
final importProvider = ChangeNotifierProvider((ref) => ImportProvider());

/// Controller which handles the importing of lists.
class ImportProvider extends ChangeNotifier {
  List<CollectionInfo> _collections = [];

  ImportProviderStates _state = ImportProviderStates.idle;

  ImportProviderJobs _job = ImportProviderJobs.idle;

  /// The current job of the import provider.
  ImportProviderJobs get job => _job;

  /// The current state of the import provider.
  ImportProviderStates get state => _state;

  /// The collections which were imported.
  List<CollectionInfo> get collections => _collections;

  /// Imports lists from older versions of the app.
  void importFromOlderVersions() async {
    _job = ImportProviderJobs.olderVersions;
    _state = ImportProviderStates.importing;
    notifyListeners();

    var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['exe'],
    );

    if (result == null) {
      _state = ImportProviderStates.idle;
      notifyListeners();
      return;
    }

    var path = result.files.first.path!;

    var file = File(path);

    var dir = file.parent;

    var saves = Directory('${dir.path}/Saves/Collections');

    if (!saves.existsSync()) {
      _state = ImportProviderStates.error;
      notifyListeners();
      return;
    }

    _state = ImportProviderStates.importing;
    notifyListeners();

    await Future.delayed(Duration(seconds: 5));

    var collectionFiles = saves.listSync();

    List<CollectionInfo> collections = [];

    for (var file in collectionFiles) {
      var f = File(file.path);

      var data = await f.readAsString();

      var json = jsonDecode(data);

      /// I know its stupid to directly store the password in the json, I was stupid when I wrote it.
      var password = json['password'] as String;

      var name = json['name'] as String;

      var entries = Map.of(json['Value']);

      var collection = CollectionInfo(
        name: name,
        password: password,
        entries: entries.cast<String, String>(),
      );

      collections.add(collection);
    }

    _state = ImportProviderStates.success;
    notifyListeners();

    _collections = collections;
  }
}

/// The current job the import provider is doing.
enum ImportProviderJobs {
  /// The import provider is idle.
  idle,

  /// Importing from older versions of the app.
  olderVersions,

  /// Importing from a file.
  file
}

/// [ImportProvider] states.
enum ImportProviderStates {
  /// The [ImportProvider] is idling.
  idle,

  /// The [ImportProvider] is importing.
  importing,

  /// The import resulted in an error.
  error,

  /// The import was successful.
  success,
}

/// Extensions for [ImportProviderStates].
extension ImportProviderStatesExtension on ImportProviderStates {
  /// Returns whether the [ImportProvider] is idling.
  bool get isIdle => this == ImportProviderStates.idle;

  /// Returns whether the [ImportProvider] is importing.
  bool get isImporting => this == ImportProviderStates.importing;

  /// Whether the import resulted in an error.
  bool get isError => this == ImportProviderStates.error;

  /// Whether the import was successful.
  bool get isSuccess => this == ImportProviderStates.success;
}

/// Extensions for [ImportProviderJobs].
extension ImportProviderJobsExtension on ImportProviderJobs {
  /// Returns whether the [ImportProvider] is idling.
  bool get isIdle => this == ImportProviderJobs.idle;

  /// Returns whether the [ImportProvider] is importing from older versions.
  bool get isOlderVersions => this == ImportProviderJobs.olderVersions;

  /// Returns whether the [ImportProvider] is importing from a file.
  bool get isFile => this == ImportProviderJobs.file;
}

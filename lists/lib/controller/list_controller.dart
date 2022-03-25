part of controllers;

/// The provider to display a collection.
final collectionProvider = ChangeNotifierProvider.autoDispose((ref) => CollectionProvider());

/// The provider to display a collection.
class CollectionProvider extends ChangeNotifier {
  late Collection _collection;
  late String _password;
  late BuildContext _context;
  bool _hasCollection = false;

  /// Sets the collection to display.
  set(String name, String password, BuildContext context) {
    log("has collection: $_hasCollection, name: $name, password: ${password.isNotEmpty}, prev: ${_hasCollection ? _collection.name : "null"}", LogTypes.debug);

    if (_hasCollection && _collection.name == name) {
      log("collection already loaded", LogTypes.tracking);
      return;
    }

    if (_hasCollection && !loaded) {
      log("collection already loading", LogTypes.tracking);
      return;
    }

    if (_hasCollection) {
      _collection.dispose();
    }

    _password = password;
    _context = context;
    _collection = DB.getCollection(name);
    _hasCollection = true;

    _collection.load(password).then((value) => notifyListeners());
  }

  /// The password of the collection.
  String get password => _password;

  /// Whether the collection is loaded.
  bool get loaded => _collection.loaded;

  /// The contents of the collection.
  Map<String, String> get entries => _collection.entries;

  /// The name of the collection.
  String get name => _collection.name;

  /// Creates a new entry.
  /// Returns false if the creation failed.
  Future<bool> createNewEntry() async {
    bool result = false;
    await showDialog(
      context: _context,
      builder: (context) => CreateNewEntryDialog(
          onCreate: (key, value) async {
            result = await _collection.addEntry(password, key, value);
          },
          collection: _collection),
    );

    if (result) {
      notifyListeners();
    } else {
      await showAlertDialog(_context, "Error", "Entry with this key already exists!");
    }

    return result;
  }

  /// Deletes an entry.
  /// Returns false if the deletion failed.
  Future<bool> removeEntry(String key) async {
    var result = await _collection.removeEntry(password, key);

    notifyListeners();

    return result;
  }

  /// Resets the provider and disposes the collection.
  void reset() {
    _collection.dispose();
    _hasCollection = false;
  }
}

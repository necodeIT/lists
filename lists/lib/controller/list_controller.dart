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
  set(String name, String password, BuildContext context) async {
    if (_hasCollection && _collection.name == name) return;

    if (_hasCollection) {
      _collection.dispose();
    }

    _password = password;
    _context = context;
    _collection = DB.getCollection(name);
    _hasCollection = true;

    await _collection.load(password);
    notifyListeners();
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

  @override
  void dispose() {
    _collection.dispose();
    super.dispose();
  }
}

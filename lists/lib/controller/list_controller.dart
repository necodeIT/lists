part of controllers;

final collectionProvider = ChangeNotifierProvider.autoDispose((ref) => CollectionProvider());

class CollectionProvider extends ChangeNotifier {
  late Collection _collection;
  late String _password;
  late BuildContext _context;
  bool hasCollection = false;

  set(String name, String password, BuildContext context) async {
    if (hasCollection && _collection.name == name) return;

    if (hasCollection) {
      _collection.dispose();
    }

    _password = password;
    _context = context;
    _collection = DB.getCollection(name);

    await _collection.load(password);
    notifyListeners();
  }

  String get password => _password;
  bool get loaded => _collection.loaded;
  Map<String, String> get entries => _collection.entries;
  String get name => _collection.name;

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

  Future<bool> removeEntry(String key) async {
    var result = await _collection.removeEntry(password, key);

    notifyListeners();

    return result;
  }

  @override
  void dispose() {
    print("disposed");
    _collection.dispose();
    super.dispose();
  }
}

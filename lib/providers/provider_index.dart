part of lists_engine;

/// A [Provider] that indexes [CollectionMetaData] and [Collection]s.
class IndexProvider extends StateNotifier<Index> {
  String _hash(String value) => sha256.convert(utf8.encode(value)).toString();
  Future<void> _save() => IndexDisk.saveIndex(state);

  /// A [Provider] that indexes [CollectionMetaData] and [Collection]s.
  IndexProvider() : super(const {}) {
    state = IndexDisk.data!;
  }

  /// Creates a new [Collection] and adds it to the index.
  void createCollectoin(String name, String? password) {
    assert(!state.containsKey(name), "Collection with name '$name' already exists.");

    final collection = Collection(name: name);

    final metaData = CollectionMetaData(
      name: name,
      hash: _hash(name),
      protected: password != null,
      size: 0,
    );

    final link = IndexLink(collection: collection, metaData: metaData);

    state = {...state, link.metaData.name: link};

    _save();
  }

  /// Renames a [Collection].
  void renameCollection(String oldName, String newName) {
    assert(state.containsKey(oldName), "Collection with name '$oldName' does not exist.");
    assert(!state.containsKey(newName), "Collection with name '$newName' already exists.");

    final link = state[oldName]!;

    link.copyWith.collection(name: newName).copyWith.metaData(name: newName);

    state.remove(oldName);
    state = {...state, newName: link};

    _save();
  }

  /// Deletes a [Collection].
  void deleteCollection(String name) {
    assert(state.containsKey(name), "Collection with name '$name' does not exist.");

    state.remove(name);

    _save();
  }
}

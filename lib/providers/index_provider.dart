part of lists_engine;

/// A [Provider] that indexes [CollectionMetaData] and [Collection]s.
class IndexProvider extends StateNotifier<Index> {
  Future<void> _save() => IndexDisk.saveIndex(state);

  /// A [Provider] that indexes [CollectionMetaData] and [Collection]s.
  IndexProvider() : super(const {}) {
    state = IndexDisk.data!;
  }

  /// Creates a new [Collection] and adds it to the index.
  Future<void> createCollectoin(String name, String? password) async {
    assert(!state.containsKey(name), "Collection with name '$name' already exists.");

    final metaData = CollectionMetaData(
      name: name,
      protected: password != null,
      size: 0,
    );

    state = {...state, metaData.name: metaData};

    await _save();
  }

  /// Renames a [Collection].
  Future<void> renameCollection(String oldName, String newName) async {
    assert(state.containsKey(oldName), "Collection with name '$oldName' does not exist.");
    assert(!state.containsKey(newName), "Collection with name '$newName' already exists.");

    final metaData = state[oldName]!;

    var newMetaData = metaData.copyWith(name: newName);

    state.remove(oldName);
    state = {...state, newName: newMetaData};

    await _save();
  }

  /// Deletes a [Collection].
  Future<void> deleteCollection(String name) async {
    assert(state.containsKey(name), "Collection with name '$name' does not exist.");

    var metaData = state[name]!;

    state.remove(name);

    await CollectionDisk.deleteCollection(metaData);

    await _save();
  }
}

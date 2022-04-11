import 'dart:typed_data';

/// Contains information about an extracted collection.
class CollectionInfo {
  /// Contains information about an extracted collection.
  CollectionInfo({required this.entries, required this.name, required this.password, Uint8List? icon}) {
    this.icon = icon ?? Uint8List(0);
  }

  /// The entries of the collection.
  final Map<String, String> entries;

  /// The name of the collection.
  final String name;

  /// The password of the collection.
  final String password;

  /// The icon of the collection.
  late final Uint8List icon;

  /// Whether the collection is protected.
  bool get passwordProtected => password.isNotEmpty;

  @override
  String toString() => 'CollectionInfo(entries: $entries, name: $name, password: $password, icon: $icon)';
}

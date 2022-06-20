import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lists_engine/lists_engine.dart';

part 'model_collection_meta_data.freezed.dart';

/// Contains meta data saved to an index file about a [Collection].
@freezed
class CollectionMetaData with _$CollectionMetaData {
  const CollectionMetaData._();

  /// Contains meta data saved to an index file about a [Collection].
  const factory CollectionMetaData({
    /// The name of the collection.
    required String name,

    /// The sha256 hash of the collection name.
    required String hash,

    /// Whether the collection is passwrod protected.
    required bool protected,

    /// The count of items in the collection.
    required int size,

    /// The url or path to the icon of the collection.
    String? img,
  }) = _CollectionMetaData;

  /// [CollectionMetaData] from json.
  factory CollectionMetaData.fromJson(Map<String, dynamic> json) => _$CollectionMetaDataFromJson(json);

  /// The path to the encrypted file where the collection is saved.
  Future<String> get path async => '${(await Disk.appDir).path}/$hash.json';

  Future<File> get file async => File(await path);
}

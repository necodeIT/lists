import 'dart:convert';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lists_engine/lists_engine.dart';
import 'package:crypto/crypto.dart';

part 'collection_meta_data_model.freezed.dart';
part 'collection_meta_data_model.g.dart';

/// Contains meta data saved to an index file about a [Collection].
@freezed
class CollectionMetaData with _$CollectionMetaData {
  const CollectionMetaData._();

  /// Contains meta data saved to an index file about a [Collection].
  const factory CollectionMetaData({
    /// The name of the collection.
    required String name,

    /// Whether the collection is passwrod protected.
    required bool protected,

    /// The count of items in the collection.
    required int size,

    /// The url or path to the icon of the collection.
    String? img,
  }) = _CollectionMetaData;

  /// [CollectionMetaData] from json.
  factory CollectionMetaData.fromJson(Map<String, dynamic> json) => _$CollectionMetaDataFromJson(json);

  /// The sha256 hash of the collection name.
  String get hash => sha256.convert(utf8.encode(name)).toString();

  /// The path to the encrypted file where the collection is saved.
  Future<String> get path async => '${(await Disk.appDir).path}/$hash.json';

  /// The file where the collection is saved.
  Future<File> get file async => File(await path);
}

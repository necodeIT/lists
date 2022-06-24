import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_model.freezed.dart';
part 'collection_model.g.dart';

/// A collection created by a user containing key value pairs.
@freezed
class Collection with _$Collection {
  const Collection._();

  /// A collection created by a user containing key value pairs.
  const factory Collection({
    /// The name of the collection
    required String name,

    /// The content of the collection
    @Default({}) Map<String, String> content,
  }) = _Collection;

  /// [Collection] from json.
  factory Collection.fromJson(Map<String, dynamic> json) => _$CollectionFromJson(json);
}

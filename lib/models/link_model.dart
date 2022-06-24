import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lists_engine/lists_engine.dart';

part 'link_model.freezed.dart';

/// Links [CollectionMetaData] with a [Collection].
@freezed
class IndexLink with _$IndexLink {
  /// Links [CollectionMetaData] with a [Collection].
  // @Assert('collection.name == metaData.name', 'Incompatible collection and meta data')
  const factory IndexLink({
    /// The [Collection] linked to the [metaData].
    required Collection collection,

    /// The [CollectionMetaData] linked to the [collection].
    required CollectionMetaData metaData,
  }) = _IndexLink;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lists_engine/lists_engine.dart';

part 'model_link.freezed.dart';

/// Links [CollectionMetaData] with a [Collection].
@freezed
class IndexLink with _$IndexLink {
  /// Links [CollectionMetaData] with a [Collection].
  @Assert('collection.name == metaData.name', 'Incompatible collection and meta data')
  const factory IndexLink({
    required Collection collection,
    required CollectionMetaData metaData,
  }) = _IndexLink;
}

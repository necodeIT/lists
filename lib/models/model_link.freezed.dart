// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'model_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$IndexLink {
  Collection get collection => throw _privateConstructorUsedError;
  CollectionMetaData get metaData => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IndexLinkCopyWith<IndexLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IndexLinkCopyWith<$Res> {
  factory $IndexLinkCopyWith(IndexLink value, $Res Function(IndexLink) then) =
      _$IndexLinkCopyWithImpl<$Res>;
  $Res call({Collection collection, CollectionMetaData metaData});

  $CollectionCopyWith<$Res> get collection;
  $CollectionMetaDataCopyWith<$Res> get metaData;
}

/// @nodoc
class _$IndexLinkCopyWithImpl<$Res> implements $IndexLinkCopyWith<$Res> {
  _$IndexLinkCopyWithImpl(this._value, this._then);

  final IndexLink _value;
  // ignore: unused_field
  final $Res Function(IndexLink) _then;

  @override
  $Res call({
    Object? collection = freezed,
    Object? metaData = freezed,
  }) {
    return _then(_value.copyWith(
      collection: collection == freezed
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as Collection,
      metaData: metaData == freezed
          ? _value.metaData
          : metaData // ignore: cast_nullable_to_non_nullable
              as CollectionMetaData,
    ));
  }

  @override
  $CollectionCopyWith<$Res> get collection {
    return $CollectionCopyWith<$Res>(_value.collection, (value) {
      return _then(_value.copyWith(collection: value));
    });
  }

  @override
  $CollectionMetaDataCopyWith<$Res> get metaData {
    return $CollectionMetaDataCopyWith<$Res>(_value.metaData, (value) {
      return _then(_value.copyWith(metaData: value));
    });
  }
}

/// @nodoc
abstract class _$$_IndexLinkCopyWith<$Res> implements $IndexLinkCopyWith<$Res> {
  factory _$$_IndexLinkCopyWith(
          _$_IndexLink value, $Res Function(_$_IndexLink) then) =
      __$$_IndexLinkCopyWithImpl<$Res>;
  @override
  $Res call({Collection collection, CollectionMetaData metaData});

  @override
  $CollectionCopyWith<$Res> get collection;
  @override
  $CollectionMetaDataCopyWith<$Res> get metaData;
}

/// @nodoc
class __$$_IndexLinkCopyWithImpl<$Res> extends _$IndexLinkCopyWithImpl<$Res>
    implements _$$_IndexLinkCopyWith<$Res> {
  __$$_IndexLinkCopyWithImpl(
      _$_IndexLink _value, $Res Function(_$_IndexLink) _then)
      : super(_value, (v) => _then(v as _$_IndexLink));

  @override
  _$_IndexLink get _value => super._value as _$_IndexLink;

  @override
  $Res call({
    Object? collection = freezed,
    Object? metaData = freezed,
  }) {
    return _then(_$_IndexLink(
      collection: collection == freezed
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as Collection,
      metaData: metaData == freezed
          ? _value.metaData
          : metaData // ignore: cast_nullable_to_non_nullable
              as CollectionMetaData,
    ));
  }
}

/// @nodoc

class _$_IndexLink implements _IndexLink {
  const _$_IndexLink({required this.collection, required this.metaData});

  @override
  final Collection collection;
  @override
  final CollectionMetaData metaData;

  @override
  String toString() {
    return 'IndexLink(collection: $collection, metaData: $metaData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IndexLink &&
            const DeepCollectionEquality()
                .equals(other.collection, collection) &&
            const DeepCollectionEquality().equals(other.metaData, metaData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(collection),
      const DeepCollectionEquality().hash(metaData));

  @JsonKey(ignore: true)
  @override
  _$$_IndexLinkCopyWith<_$_IndexLink> get copyWith =>
      __$$_IndexLinkCopyWithImpl<_$_IndexLink>(this, _$identity);
}

abstract class _IndexLink implements IndexLink {
  const factory _IndexLink(
      {required final Collection collection,
      required final CollectionMetaData metaData}) = _$_IndexLink;

  @override
  Collection get collection => throw _privateConstructorUsedError;
  @override
  CollectionMetaData get metaData => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_IndexLinkCopyWith<_$_IndexLink> get copyWith =>
      throw _privateConstructorUsedError;
}

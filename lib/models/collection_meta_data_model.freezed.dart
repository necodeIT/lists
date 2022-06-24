// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'collection_meta_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CollectionMetaData _$CollectionMetaDataFromJson(Map<String, dynamic> json) {
  return _CollectionMetaData.fromJson(json);
}

/// @nodoc
mixin _$CollectionMetaData {
  /// The name of the collection.
  String get name => throw _privateConstructorUsedError;

  /// Whether the collection is passwrod protected.
  bool get protected => throw _privateConstructorUsedError;

  /// The count of items in the collection.
  int get size => throw _privateConstructorUsedError;

  /// The url or path to the icon of the collection.
  String? get img => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CollectionMetaDataCopyWith<CollectionMetaData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionMetaDataCopyWith<$Res> {
  factory $CollectionMetaDataCopyWith(
          CollectionMetaData value, $Res Function(CollectionMetaData) then) =
      _$CollectionMetaDataCopyWithImpl<$Res>;
  $Res call({String name, bool protected, int size, String? img});
}

/// @nodoc
class _$CollectionMetaDataCopyWithImpl<$Res>
    implements $CollectionMetaDataCopyWith<$Res> {
  _$CollectionMetaDataCopyWithImpl(this._value, this._then);

  final CollectionMetaData _value;
  // ignore: unused_field
  final $Res Function(CollectionMetaData) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? protected = freezed,
    Object? size = freezed,
    Object? img = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      protected: protected == freezed
          ? _value.protected
          : protected // ignore: cast_nullable_to_non_nullable
              as bool,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      img: img == freezed
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_CollectionMetaDataCopyWith<$Res>
    implements $CollectionMetaDataCopyWith<$Res> {
  factory _$$_CollectionMetaDataCopyWith(_$_CollectionMetaData value,
          $Res Function(_$_CollectionMetaData) then) =
      __$$_CollectionMetaDataCopyWithImpl<$Res>;
  @override
  $Res call({String name, bool protected, int size, String? img});
}

/// @nodoc
class __$$_CollectionMetaDataCopyWithImpl<$Res>
    extends _$CollectionMetaDataCopyWithImpl<$Res>
    implements _$$_CollectionMetaDataCopyWith<$Res> {
  __$$_CollectionMetaDataCopyWithImpl(
      _$_CollectionMetaData _value, $Res Function(_$_CollectionMetaData) _then)
      : super(_value, (v) => _then(v as _$_CollectionMetaData));

  @override
  _$_CollectionMetaData get _value => super._value as _$_CollectionMetaData;

  @override
  $Res call({
    Object? name = freezed,
    Object? protected = freezed,
    Object? size = freezed,
    Object? img = freezed,
  }) {
    return _then(_$_CollectionMetaData(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      protected: protected == freezed
          ? _value.protected
          : protected // ignore: cast_nullable_to_non_nullable
              as bool,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      img: img == freezed
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CollectionMetaData extends _CollectionMetaData {
  const _$_CollectionMetaData(
      {required this.name,
      required this.protected,
      required this.size,
      this.img})
      : super._();

  factory _$_CollectionMetaData.fromJson(Map<String, dynamic> json) =>
      _$$_CollectionMetaDataFromJson(json);

  /// The name of the collection.
  @override
  final String name;

  /// Whether the collection is passwrod protected.
  @override
  final bool protected;

  /// The count of items in the collection.
  @override
  final int size;

  /// The url or path to the icon of the collection.
  @override
  final String? img;

  @override
  String toString() {
    return 'CollectionMetaData(name: $name, protected: $protected, size: $size, img: $img)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CollectionMetaData &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.protected, protected) &&
            const DeepCollectionEquality().equals(other.size, size) &&
            const DeepCollectionEquality().equals(other.img, img));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(protected),
      const DeepCollectionEquality().hash(size),
      const DeepCollectionEquality().hash(img));

  @JsonKey(ignore: true)
  @override
  _$$_CollectionMetaDataCopyWith<_$_CollectionMetaData> get copyWith =>
      __$$_CollectionMetaDataCopyWithImpl<_$_CollectionMetaData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CollectionMetaDataToJson(this);
  }
}

abstract class _CollectionMetaData extends CollectionMetaData {
  const factory _CollectionMetaData(
      {required final String name,
      required final bool protected,
      required final int size,
      final String? img}) = _$_CollectionMetaData;
  const _CollectionMetaData._() : super._();

  factory _CollectionMetaData.fromJson(Map<String, dynamic> json) =
      _$_CollectionMetaData.fromJson;

  @override

  /// The name of the collection.
  String get name => throw _privateConstructorUsedError;
  @override

  /// Whether the collection is passwrod protected.
  bool get protected => throw _privateConstructorUsedError;
  @override

  /// The count of items in the collection.
  int get size => throw _privateConstructorUsedError;
  @override

  /// The url or path to the icon of the collection.
  String? get img => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CollectionMetaDataCopyWith<_$_CollectionMetaData> get copyWith =>
      throw _privateConstructorUsedError;
}

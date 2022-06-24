// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Settings _$SettingsFromJson(Map<String, dynamic> json) {
  return _Settings.fromJson(json);
}

/// @nodoc
mixin _$Settings {
  /// The name of the theme the user has selected.
  String get theme => throw _privateConstructorUsedError;

  /// The language the user has selected.
  String get language => throw _privateConstructorUsedError;

  /// Whether to sync the accent color with the system.
  bool get adaptiveAccent => throw _privateConstructorUsedError;

  /// Whether to sync the app with the cloud.
  bool get sync => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingsCopyWith<Settings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsCopyWith<$Res> {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) then) =
      _$SettingsCopyWithImpl<$Res>;
  $Res call({String theme, String language, bool adaptiveAccent, bool sync});
}

/// @nodoc
class _$SettingsCopyWithImpl<$Res> implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._value, this._then);

  final Settings _value;
  // ignore: unused_field
  final $Res Function(Settings) _then;

  @override
  $Res call({
    Object? theme = freezed,
    Object? language = freezed,
    Object? adaptiveAccent = freezed,
    Object? sync = freezed,
  }) {
    return _then(_value.copyWith(
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      adaptiveAccent: adaptiveAccent == freezed
          ? _value.adaptiveAccent
          : adaptiveAccent // ignore: cast_nullable_to_non_nullable
              as bool,
      sync: sync == freezed
          ? _value.sync
          : sync // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_SettingsCopyWith<$Res> implements $SettingsCopyWith<$Res> {
  factory _$$_SettingsCopyWith(
          _$_Settings value, $Res Function(_$_Settings) then) =
      __$$_SettingsCopyWithImpl<$Res>;
  @override
  $Res call({String theme, String language, bool adaptiveAccent, bool sync});
}

/// @nodoc
class __$$_SettingsCopyWithImpl<$Res> extends _$SettingsCopyWithImpl<$Res>
    implements _$$_SettingsCopyWith<$Res> {
  __$$_SettingsCopyWithImpl(
      _$_Settings _value, $Res Function(_$_Settings) _then)
      : super(_value, (v) => _then(v as _$_Settings));

  @override
  _$_Settings get _value => super._value as _$_Settings;

  @override
  $Res call({
    Object? theme = freezed,
    Object? language = freezed,
    Object? adaptiveAccent = freezed,
    Object? sync = freezed,
  }) {
    return _then(_$_Settings(
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      adaptiveAccent: adaptiveAccent == freezed
          ? _value.adaptiveAccent
          : adaptiveAccent // ignore: cast_nullable_to_non_nullable
              as bool,
      sync: sync == freezed
          ? _value.sync
          : sync // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Settings extends _Settings {
  const _$_Settings(
      {required this.theme,
      required this.language,
      required this.adaptiveAccent,
      required this.sync})
      : super._();

  factory _$_Settings.fromJson(Map<String, dynamic> json) =>
      _$$_SettingsFromJson(json);

  /// The name of the theme the user has selected.
  @override
  final String theme;

  /// The language the user has selected.
  @override
  final String language;

  /// Whether to sync the accent color with the system.
  @override
  final bool adaptiveAccent;

  /// Whether to sync the app with the cloud.
  @override
  final bool sync;

  @override
  String toString() {
    return 'Settings(theme: $theme, language: $language, adaptiveAccent: $adaptiveAccent, sync: $sync)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Settings &&
            const DeepCollectionEquality().equals(other.theme, theme) &&
            const DeepCollectionEquality().equals(other.language, language) &&
            const DeepCollectionEquality()
                .equals(other.adaptiveAccent, adaptiveAccent) &&
            const DeepCollectionEquality().equals(other.sync, sync));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(theme),
      const DeepCollectionEquality().hash(language),
      const DeepCollectionEquality().hash(adaptiveAccent),
      const DeepCollectionEquality().hash(sync));

  @JsonKey(ignore: true)
  @override
  _$$_SettingsCopyWith<_$_Settings> get copyWith =>
      __$$_SettingsCopyWithImpl<_$_Settings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SettingsToJson(this);
  }
}

abstract class _Settings extends Settings {
  const factory _Settings(
      {required final String theme,
      required final String language,
      required final bool adaptiveAccent,
      required final bool sync}) = _$_Settings;
  const _Settings._() : super._();

  factory _Settings.fromJson(Map<String, dynamic> json) = _$_Settings.fromJson;

  @override

  /// The name of the theme the user has selected.
  String get theme => throw _privateConstructorUsedError;
  @override

  /// The language the user has selected.
  String get language => throw _privateConstructorUsedError;
  @override

  /// Whether to sync the accent color with the system.
  bool get adaptiveAccent => throw _privateConstructorUsedError;
  @override

  /// Whether to sync the app with the cloud.
  bool get sync => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_SettingsCopyWith<_$_Settings> get copyWith =>
      throw _privateConstructorUsedError;
}

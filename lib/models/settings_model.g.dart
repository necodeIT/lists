// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Settings _$$_SettingsFromJson(Map<String, dynamic> json) => _$_Settings(
      theme: json['theme'] as String,
      language: json['language'] as String,
      adaptiveAccent: json['adaptiveAccent'] as bool,
      sync: json['sync'] as bool,
    );

Map<String, dynamic> _$$_SettingsToJson(_$_Settings instance) =>
    <String, dynamic>{
      'theme': instance.theme,
      'language': instance.language,
      'adaptiveAccent': instance.adaptiveAccent,
      'sync': instance.sync,
    };

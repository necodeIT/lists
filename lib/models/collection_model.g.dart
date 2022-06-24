// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Collection _$$_CollectionFromJson(Map<String, dynamic> json) =>
    _$_Collection(
      name: json['name'] as String,
      content: (json['content'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$$_CollectionToJson(_$_Collection instance) =>
    <String, dynamic>{
      'name': instance.name,
      'content': instance.content,
    };

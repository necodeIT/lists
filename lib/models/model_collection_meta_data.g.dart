// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_collection_meta_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CollectionMetaData _$$_CollectionMetaDataFromJson(
        Map<String, dynamic> json) =>
    _$_CollectionMetaData(
      name: json['name'] as String,
      protected: json['protected'] as bool,
      size: json['size'] as int,
      img: json['img'] as String?,
    );

Map<String, dynamic> _$$_CollectionMetaDataToJson(
        _$_CollectionMetaData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'protected': instance.protected,
      'size': instance.size,
      'img': instance.img,
    };

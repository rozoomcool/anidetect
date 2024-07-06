// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_row_default.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DataRowDefaultImpl _$$DataRowDefaultImplFromJson(Map<String, dynamic> json) =>
    _$DataRowDefaultImpl(
      image_name: json['image_name'] as String,
      class_name: json['class_name'] as String,
      count: (json['count'] as num).toInt(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$$DataRowDefaultImplToJson(
        _$DataRowDefaultImpl instance) =>
    <String, dynamic>{
      'image_name': instance.image_name,
      'class_name': instance.class_name,
      'count': instance.count,
      'confidence': instance.confidence,
    };

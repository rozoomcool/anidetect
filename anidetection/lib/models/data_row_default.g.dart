// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_row_default.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DataRowDefaultImpl _$$DataRowDefaultImplFromJson(Map<String, dynamic> json) =>
    _$DataRowDefaultImpl(
      folderName: json['folderName'] as String? ?? "0",
      imageName: json['imageName'] as String,
      className: json['className'] as String,
      count: (json['count'] as num).toInt(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$$DataRowDefaultImplToJson(
        _$DataRowDefaultImpl instance) =>
    <String, dynamic>{
      'folderName': instance.folderName,
      'imageName': instance.imageName,
      'className': instance.className,
      'count': instance.count,
      'confidence': instance.confidence,
    };

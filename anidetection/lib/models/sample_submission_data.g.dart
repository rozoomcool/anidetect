// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_submission_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SampleSubmissionDataImpl _$$SampleSubmissionDataImplFromJson(
        Map<String, dynamic> json) =>
    _$SampleSubmissionDataImpl(
      nameFolder: json['nameFolder'] as String,
      imageName: json['imageName'] as String,
      className: json['className'] as String,
      dateRegistrationStart:
          DateTime.parse(json['dateRegistrationStart'] as String),
      dateRegistrationEnd:
          DateTime.parse(json['dateRegistrationEnd'] as String),
      count: (json['count'] as num).toInt(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$$SampleSubmissionDataImplToJson(
        _$SampleSubmissionDataImpl instance) =>
    <String, dynamic>{
      'nameFolder': instance.nameFolder,
      'imageName': instance.imageName,
      'className': instance.className,
      'dateRegistrationStart': instance.dateRegistrationStart.toIso8601String(),
      'dateRegistrationEnd': instance.dateRegistrationEnd.toIso8601String(),
      'count': instance.count,
      'confidence': instance.confidence,
    };

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sample_submission_data.g.dart';

part 'sample_submission_data.freezed.dart';

@freezed
class SampleSubmissionData with _$SampleSubmissionData {
  const factory SampleSubmissionData(
      {
        required String nameFolder,
        required String imageName,
        required String className,
        required DateTime dateRegistrationStart,
        required DateTime dateRegistrationEnd,
        required int count,
        required double confidence}) = _SampleSubmissionData;

  factory SampleSubmissionData.fromJson(Map<String, Object?> json)
  => _$SampleSubmissionDataFromJson(json);
}

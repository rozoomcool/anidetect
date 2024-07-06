import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_row_default.g.dart';

part 'data_row_default.freezed.dart';

@freezed
class DataRowDefault with _$DataRowDefault {
  const factory DataRowDefault(
      {required String image_name,
      required String class_name,
      required int count,
      required double confidence}) = _DataRowDefault;

  factory DataRowDefault.fromJson(Map<String, Object?> json)
  => _$DataRowDefaultFromJson(json);
}

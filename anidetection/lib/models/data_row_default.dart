import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_row_default.g.dart';

part 'data_row_default.freezed.dart';

@freezed
class DataRowDefault with _$DataRowDefault {
  const factory DataRowDefault(
      {
        @Default("0") String folderName,
        required String imageName,
      required String className,
      required int count,
      required double confidence}) = _DataRowDefault;

  factory DataRowDefault.fromJson(Map<String, Object?> json)
  => _$DataRowDefaultFromJson(json);
}

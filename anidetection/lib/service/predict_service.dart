import 'package:anidetection/models/data_row_default.dart';
import 'package:dio/dio.dart';

class PredictService {
  final Dio _dio;

  PredictService(this._dio);

  // Future<String> predictData(List<MultipartFile> files) async {
  //   FormData formData = FormData();
  //   for (var file in files) {
  //     formData.files.add(MapEntry("files", file));
  //   }
  //   var response = await _dio.post("/predict", data: formData);
  //
  //   return response.data as String;
  // }

  Future<List<DataRowDefault>> predictData(List<MultipartFile> files) async {
    FormData formData = FormData();
    for (var file in files) {
      formData.files.add(MapEntry("files", file));
    }
    var response = await _dio.post("/predict", data: formData);

    return (response.data as List<Map<String, Object?>>)
        .map<DataRowDefault>((el) => DataRowDefault.fromJson(el))
        .toList();
  }
}

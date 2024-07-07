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
    List<DataRowDefault> resultData = List.empty(growable: true);

    FormData formData = FormData();
    for (int i = 0; i < files.length; i++) {
      formData.files.add(MapEntry("files", files[i]));
      // int maxx = files.length - i > 400 ? 400 : files.length - i;
      if (i % 400 == 0) {
        var response = await _dio.post("/predict", data: formData);

        List<DataRowDefault> temp = (response.data as List<dynamic>)
            .map<DataRowDefault>((el) => DataRowDefault.fromJson(el))
            .toList();
        resultData.addAll(temp);

        formData = FormData();
      }

      if (formData.files.isNotEmpty) {
        var response = await _dio.post("/predict", data: formData);

        List<DataRowDefault> temp = (response.data as List<dynamic>)
            .map<DataRowDefault>((el) => DataRowDefault.fromJson(el))
            .toList();
        resultData.addAll(temp);
        formData = FormData();
      }
    }

    return resultData;
  }

  // Функция для разбивки списка на чанки
  List<List<T>> chunkList<T>(List<T> list, int chunkSize) {
    List<List<T>> chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(
        list.sublist(
          i,
          i + chunkSize > list.length ? list.length : i + chunkSize,
        ),
      );
    }
    return chunks;
  }
}

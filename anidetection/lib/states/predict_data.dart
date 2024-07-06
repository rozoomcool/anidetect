// import 'dart:io';
//
// import 'package:anidetection/service/predict_service.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get_it/get_it.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// @riverpod
// class PredictData extends _$PredictData {
//   String build() => "";
//
//   final _predictService = PredictService(GetIt.I<Dio>());
//
//   void predictData(List<File> files) async {
//     List<MultipartFile> multiparts = [];
//     for (int i = 0; i < files.length; i++) {
//       multiparts.add(MultipartFile.fromBytes(files[i].readAsBytesSync()));
//     }
//     _predictService.predictData(multiparts);
//   }
// }
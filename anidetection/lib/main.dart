import 'package:anidetection/constants.dart';
import 'package:anidetection/presentation/screens/main_screen.dart';
import 'package:anidetection/service/predict_service.dart';
import 'package:anidetection/states/predict_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app/app.dart';

void main() {

  GetIt.I.registerFactory<Dio>(() => Dio(BaseOptions(baseUrl: baseUrl)));
  GetIt.I.registerFactory(() => PredictService(GetIt.I<Dio>()));
  runApp(const MyApp());
}
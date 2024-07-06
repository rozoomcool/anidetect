import 'dart:io';

import 'package:anidetection/models/data_row_default.dart';
import 'package:anidetection/utils/my_tree_node.dart';
import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../service/predict_service.dart';
import '../utils/image_utils.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(EmptyDataState());

  final PredictService _predictService = GetIt.I<PredictService>();

  Future<void> pickDirectory() async {
    try {
      String? selectedDirectoryPath =
          await FilePicker.platform.getDirectoryPath();
      if (selectedDirectoryPath != null) {
        Directory directory = Directory(selectedDirectoryPath);
        MyTreeNode directoryTree = await _buildDirectoryTree(directory);
        emit(DirectoryDataState(directoryTree));
      }
    } catch (e) {
      debugPrint("$e");
      emit(ErrorDataState("Error load input data"));
    }
  }

  Future<MyTreeNode> _buildDirectoryTree(Directory directory) async {
    emit(LoadingDataState());
    List<MyTreeNode> children = [];
    try {
      await for (FileSystemEntity entity
          in directory.list(recursive: false, followLinks: false)) {
        if (entity is Directory) {
          MyTreeNode subDir = await _buildDirectoryTree(entity);
          children.add(subDir);
        } else if (entity is File) {
          children.add(MyTreeNode(title: entity.path.split('/').last));
        }
      }
    } catch (e) {
      print("Error reading directory: $e");
    }
    return MyTreeNode(
      title: directory.path.split("\\").last,
      children: children,
    );
  }

  void predictData() async {
    try {
      List<MyTreeNode> cameras =
          (state as DirectoryDataState).rootNode.children.toList();

      List<String> imagesPath = [];

      for (int i = 0; i < cameras.length; i++) {
        for (int j = 0; j < cameras[i].children.length; j++) {
          imagesPath.add(cameras[i].children[j].title);
        }
      }

      imagesPath = imagesPath.where((el) => isImageFile(el)).toList();

      List<MultipartFile> multiparts = imagesPath
          .map<MultipartFile>((el) => MultipartFile.fromFileSync(el))
          .toList();

      List<DataRowDefault> data = await _predictService.predictData(multiparts);

      data = data.map<DataRowDefault>((el) {
        String imagePath = imagesPath
            .where((path) => path.split(pathRegex).last == el.imageName)
            .first;
        return el.copyWith(
            folderName: imagePath.split(pathRegex).reversed.toList()[1]);
      }).toList();

      var rootFolder = imagesPath[0].split(pathRegex);
      rootFolder.removeLast();
      rootFolder.removeLast();

      emit(LoadedDataState(data: data, rootFolder: rootFolder.join("/")));
    } catch (e) {
      debugPrint("$e");
      emit(ErrorDataState("Error load data from server"));
    }
  }

// void predictData() async {
//   try {
//     List<MyTreeNode> cameras =
//         (state as DirectoryDataState).rootNode.children.toList();
//
//     List<String> imagesPath = [];
//
//     for (int i = 0; i < cameras.length; i++) {
//       for (int j = 0; j < cameras[i].children.length; j++) {
//         imagesPath.add(cameras[i].children[j].title);
//       }
//     }
//
//     imagesPath = imagesPath.where((el) => isImageFile(el)).toList();
//
//     // print(imagesPath);
//
//     List<MultipartFile> mutiparts = imagesPath
//         .map<MultipartFile>((el) => MultipartFile.fromFileSync(el))
//         .toList();
//
//     // debugPrint(imagesPath.toString());
//
//     emit(LoadingDataState());
//     var result = await GetIt.I<PredictService>().predictData(mutiparts);
//
//     List<String> images = imagesPath.map<String>((el) {
//       var temp = el.split("\\").reversed.toList();
//       return "${temp[1]}/${temp[0]}"; // исправлено на temp[0]
//     }).toList();
//
//     var csv = const CsvToListConverter().convert(result);
//     List<List<dynamic>> updatedCsv = [];
//
//     // Добавляем заголовок
//     updatedCsv.add(["folder_name", ...csv[0]]);
//
//     for (int i = 1; i < csv.length; i++) {
//       String imagePath =
//           imagesPath.firstWhere((path) => path.split("\\").last == csv[i][0]);
//       String folderName = imagePath.split("\\").reversed.toList()[1];
//       updatedCsv.add([folderName, ...csv[i]]);
//     }
//
//     // debugPrint(updatedCsv.toString());
//
//     // Преобразуем обратно в CSV строку
//     String updatedCsvString = const ListToCsvConverter().convert(updatedCsv);
//     var rootFolder = imagesPath[0].split("\\");
//     rootFolder.removeLast();
//     rootFolder.removeLast();
//     emit(CsvDataState(csvData: updatedCsvString, rootFolder: rootFolder.join("/")));
//   } catch (e) {
//     debugPrint("${e}");
//     emit(ErrorDataState("Error load input data"));
//   }
// }
}

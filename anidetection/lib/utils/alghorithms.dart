import 'dart:io';
import 'package:anidetection/models/data_row_default.dart';
import 'package:anidetection/models/sample_submission_data.dart';
import 'package:anidetection/utils/utils.dart';
import 'package:csv/csv.dart';
import 'package:exif/exif.dart';
import 'package:intl/intl.dart';

final dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

Future<List<SampleSubmissionData>> processAnimalData(
    String rootFolder, List<DataRowDefault> dataRow) async {
  // Фильтрация данных по наличию метаданных
  final filteredData = <SampleSubmissionData>[];

  for (var row in dataRow) {
    final filePath = '$rootFolder/${row.folderName}/${row.imageName}';
    final file = File(filePath);

    if (file.existsSync()) {
      print('File exists: $filePath');
      final bytes = await file.readAsBytes();
      final tags = await readExifFromBytes(bytes);

      if (tags.isNotEmpty) {
        final dateTimeString = tags['Image DateTime']?.printable ??
            tags['EXIF DateTimeOriginal']?.printable ??
            tags['EXIF DateTimeDigitized']?.printable;
        print('DateTimeString: $dateTimeString');
        if (dateTimeString != null) {
          try {
            final dateTime = DateFormat("yyyy:MM:dd HH:mm:ss")
                .parse(dateTimeString, true)
                .toUtc();
            print('Parsed DateTime: $dateTime');

            var timestamp = dateTime;
            filteredData.add(SampleSubmissionData(
                nameFolder: row.folderName,
                imageName: row.imageName,
                className: row.className,
                dateRegistrationStart: timestamp,
                dateRegistrationEnd: timestamp,
                count: row.count,
                confidence: row.confidence));
          } catch (e) {
            print('Error parsing date: $e');
          }
        } else {
          print('No valid DateTimeString found in EXIF tags');
        }
      } else {
        print('No EXIF tags found for file: $filePath');
      }
    } else {
      print('File does not exist: $filePath');
    }
  }

  return filteredData;
}

// List<SampleSubmissionData> resolveAnimals(List<SampleSubmissionData> data) {
//
//   SampleSubmissionData? dp;
//   List<SampleSubmissionData> result = [];
//
//   while(data.isNotEmpty) {
//     dp = data.removeAt(0);
//     List<int> indexesToDeleted = [];
//     var copied = List<SampleSubmissionData>.from(data);
//
//      for (int i = 0; i < copied.length; i++) {
//       if(copied[i].nameFolder == dp!.nameFolder && copied[i].className == dp.className) {
//         int difference = calculateDifferenceInMinutes(copied[i].dateRegistrationStart, dp.dateRegistrationStart);
//         if (difference > 30) continue;
//
//         dp = dp.copyWith(dateRegistrationEnd: copied[i].dateRegistrationStart);
//       }
//     }
//   }
//
//   return data;
// }


List<SampleSubmissionData> mergeSampleSubmissionData(List<SampleSubmissionData> data) {
  // Создаем карту для хранения групп
  Map<String, List<SampleSubmissionData>> groupedData = {};

  // Группируем данные по nameFolder и className
  for (var entry in data) {
    String key = '${entry.nameFolder}-${entry.className}';
    if (!groupedData.containsKey(key)) {
      groupedData[key] = [];
    }
    groupedData[key]!.add(entry);
  }

  List<SampleSubmissionData> mergedData = [];

  // Обрабатываем каждую группу
  for (var group in groupedData.values) {
    // Сортируем группу по dateRegistrationStart
    group.sort((a, b) => a.dateRegistrationStart.compareTo(b.dateRegistrationStart));

    List<SampleSubmissionData> tempGroup = [];
    for (var entry in group) {
      if (tempGroup.isEmpty) {
        tempGroup.add(entry);
      } else {
        var lastEntry = tempGroup.last;
        // Проверяем условие на разницу во времени
        if (entry.dateRegistrationStart.difference(lastEntry.dateRegistrationStart).inMinutes <= 30) {
          tempGroup.add(entry);
        } else {
          // Объединяем текущую группу и добавляем в результат
          mergedData.add(_mergeEntries(tempGroup));
          tempGroup = [entry];
        }
      }
    }
    // Не забудьте объединить последнюю группу
    if (tempGroup.isNotEmpty) {
      mergedData.add(_mergeEntries(tempGroup));
    }
  }

  return mergedData;
}

SampleSubmissionData _mergeEntries(List<SampleSubmissionData> entries) {
  if (entries.isEmpty) {
    throw ArgumentError('Cannot merge empty list of entries');
  }

  String nameFolder = entries.first.nameFolder;
  String className = entries.first.className;
  DateTime dateRegistrationStart = entries.first.dateRegistrationStart;
  DateTime dateRegistrationEnd = entries.first.dateRegistrationEnd;
  int count = 0;
  double confidence = 0.0;
  List<String> imageNames = [];

  for (var entry in entries) {
    if ((entry.dateRegistrationEnd.isAfter(dateRegistrationEnd))) {
      dateRegistrationEnd = entry.dateRegistrationEnd;
    }
    if (entry.count > count) {
      count = entry.count;
    }
    confidence += entry.confidence; // Суммируем confidence
    imageNames.add(entry.imageName);
  }

  // Среднее значение confidence
  confidence = confidence / entries.length;

  return SampleSubmissionData(
    nameFolder: nameFolder,
    imageName: imageNames.join(', '), // Объединяем имена изображений через запятую
    className: className,
    dateRegistrationStart: dateRegistrationStart,
    dateRegistrationEnd: dateRegistrationEnd,
    count: count,
    confidence: confidence,
  );
}



extension on DateTime {
  DateTime floor() {
    return DateTime(year, month, day, hour);
  }
}

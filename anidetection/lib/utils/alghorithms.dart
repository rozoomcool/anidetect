import 'dart:io';
import 'package:anidetection/models/data_row_default.dart';
import 'package:anidetection/models/sample_submission_data.dart';
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
                dateRegistrationEnd: null,
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

extension on DateTime {
  DateTime floor() {
    return DateTime(year, month, day, hour);
  }
}

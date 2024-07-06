import 'dart:io';
import 'package:csv/csv.dart';
import 'package:exif/exif.dart';
import 'package:intl/intl.dart';

Future<String> processAnimalData(String rootFolder, String csvString) async {
  final fields = const CsvToListConverter().convert(csvString);

  // Преобразование строк CSV в объекты с проверкой количества элементов
  final data = fields.where((row) => row.length == 5).map((row) => {
    'folder_name': row[0],
    'image_name': row[1],
    'class_name': row[2],
    'count': row[3],
    'confidence': row[4]
  }).toList();

  print('Data loaded');

  // Фильтрация данных по наличию метаданных
  final filteredData = <Map<String, dynamic>>[];

  for (var row in data) {
    final filePath = '$rootFolder/${row['folder_name']}/${row['image_name']}';
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

            row['timestamp'] = dateTime;
            filteredData.add(row);
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

  print('Filtered data length: ${filteredData.length}');

  if (filteredData.isEmpty) {
    return const ListToCsvConverter().convert([
      [
        "name_folder",
        "class",
        "date_registration_start",
        "date_registration_end",
        "count"
      ]
    ]);
  }

  final List<List<dynamic>> csvData = [
    [
      "name_folder",
      "class",
      "date_registration_start",
      "date_registration_end",
      "count"
    ]
  ];

  final dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  filteredData.forEach((row) {
    csvData.add([
      row['folder_name'],
      row['class_name'],
      dateFormat.format(row['timestamp']),
      null,
      row['count']
    ]);
  });

  String csvResult = const ListToCsvConverter().convert(csvData);

  print(csvResult);

  return csvResult;
}

extension on DateTime {
  DateTime floor() {
    return DateTime(year, month, day, hour);
  }
}

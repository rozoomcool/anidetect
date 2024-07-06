import 'package:anidetection/models/data_row_default.dart';
import 'package:anidetection/models/sample_submission_data.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

import '../../utils/alghorithms.dart'; // Предполагается, что здесь определена функция processAnimalData

class CustomTableView extends StatefulWidget {
  const CustomTableView(
      {super.key, required this.data, required this.rootFolder});

  final List<DataRowDefault> data;
  final String rootFolder;

  @override
  State<CustomTableView> createState() => _CustomTableViewState();
}

class _CustomTableViewState extends State<CustomTableView> {
  TableRow tableHeaders() {
    return TableRow(
        children: <String>[
          "Имя папки",
          "Класс Животного",
          "Начало регистрации",
          "Конец регистрации",
          "Количество",
          "точность",
          "Название фото"
        ].map((el) =>
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  el
              ),
            )).toList()
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<SampleSubmissionData>>(
        future: processAnimalData(widget.rootFolder, widget.data),
        // future: Future.value(widget.data),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snap.hasError) {
            // debugPrint("");
            return Center(
                child: Text("Error to load table data\n${snap.error}"));
          } else if (snap.hasData) {
            var data = mergeSampleSubmissionData(snap.data!);

            var dataTableRow = <TableRow>[];
            dataTableRow.add(tableHeaders());
            dataTableRow.addAll(data.map<TableRow>((item) {
              return TableRow(
                children: <String>[
                  item.nameFolder,
                  item.className,
                  dateFormat.format(item.dateRegistrationStart),
                  item.dateRegistrationEnd != null
                      ? dateFormat.format(item.dateRegistrationEnd!)
                      : "null",
                  item.count.toString(),
                  item.confidence.toString(),
                  item.imageName
                ].map<Widget>((row) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      row.toString(),
                    ),
                  );
                }).toList(),
              );
            }));

            return Table(
              border: TableBorder.all(width: 1.0),
              children: dataTableRow,
            );
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}

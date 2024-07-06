import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

import '../../utils/alghorithms.dart'; // Предполагается, что здесь определена функция processAnimalData

class CustomTableView extends StatefulWidget {
  const CustomTableView({super.key, required this.data, required this.rootFolder});

  final String data;
  final String rootFolder;

  @override
  State<CustomTableView> createState() => _CustomTableViewState();
}

class _CustomTableViewState extends State<CustomTableView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<String>(
        future: processAnimalData(widget.rootFolder, widget.data),
        // future: Future.value(widget.data),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snap.hasError) {
            // debugPrint("");
            return Center(child: Text("Error to load table data\n${snap.error}"));
          } else if (snap.hasData) {
            List<List<dynamic>> csvData = const CsvToListConverter().convert(snap.data!);
            debugPrint(":::::::::::${csvData.length}");
            debugPrint(":::::::::::${csvData[0].length}");
            return Table(
              border: TableBorder.all(width: 1.0),
              children: csvData.map((item) {
                return TableRow(
                  children: item.map<Widget>((row) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        row.toString(),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            );
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}

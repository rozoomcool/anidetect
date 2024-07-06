import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

class CustomTableView extends StatefulWidget {
  const CustomTableView({super.key, required this.data});

  final String data;

  @override
  State<CustomTableView> createState() => _CustomTableViewState();
}

class _CustomTableViewState extends State<CustomTableView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        border: TableBorder.all(width: 1.0),
        children: const CsvToListConverter().convert(widget.data).map((item) {
          return TableRow(
              children: item.map((row) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    row.toString(),
                  ),
                );
              }).toList());
        }).toList(),
      ),
    );
  }
}

import 'package:csv/csv.dart';
import 'dart:convert';

class ReportExporter {
  String toCsv(List<Map<String,dynamic>> rows) {
    if (rows.isEmpty) return '';
    final keys = rows.first.keys.toList();
    final table = <List<dynamic>>[keys];
    for (final r in rows) {
      table.add(keys.map((k) => r[k]).toList());
    }
    return const ListToCsvConverter().convert(table);
  }

  List<int> utf8Bytes(String csv) => utf8.encode(csv);
}

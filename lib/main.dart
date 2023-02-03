import 'package:flutter/material.dart';
import 'package:todo/calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';

void main() async {
  await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TodoApp',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Calendar(),
    );
  }
}

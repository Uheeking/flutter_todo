import 'package:flutter/material.dart';
import 'package:todo/calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';

import 'bottomnavi.dart';

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
      home: Second(),
    );
  }
}

class Second extends StatefulWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    // Calendar()
  ];

  @override
  State<Second> createState() => SecondState();

  static SecondState of(BuildContext context) =>
      context.findAncestorStateOfType<SecondState>();
}

class SecondState extends State<Second> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Todo List',
          ),
        ),
        bottomNavigationBar: BottomNavi());
  }
}

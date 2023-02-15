import 'package:flutter/material.dart';
import 'package:todo/calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';

import 'package:todo/bottomnavi.dart';
import 'package:todo/controller/IndexController.dart';
import 'package:todo/controller/TodoController.dart';
import 'package:todo/todolist.dart';

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
  @override
  SecondState createState() => SecondState();
}

class SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IndexController());
    final controTodo = Get.put(TodoController());
    final List<Widget> _widgetOptions = <Widget>[
      const Todolist(),
      const Calendar(),
    ];

    return Obx(() => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Todo List'),
        ),
        body: Center(
          child: _widgetOptions.elementAt(controller.selectedIndex.value),
        ),
        bottomNavigationBar: const BottomNavi()));
  }
}

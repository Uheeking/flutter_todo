import 'package:flutter/material.dart';
import 'package:todo/calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';

import 'package:todo/bottomnavi.dart';
import 'package:todo/controller/IndexController.dart';
import 'package:todo/todolistAll.dart';

void main() async {
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TodoApp',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Second(),
    );
  }
}

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  SecondState createState() => SecondState();
}

class SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IndexController());
    final List<Widget> widgetOptions = <Widget>[
      const Calendar(),
      const TodolistAll(),
    ];

    return Obx(() => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Todo List'),
        ),
        body: Center(
          child: widgetOptions.elementAt(controller.selectedIndex.value),
        ),
        bottomNavigationBar: const BottomNavi()));
  }
}

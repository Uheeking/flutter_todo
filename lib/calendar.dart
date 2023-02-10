import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/bottomnavi.dart';
import 'package:todo/controller/TodoController.dart';
import 'package:todo/pages/todoAdd.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:todo/todolistAll.dart';
import 'package:todo/todolist.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final controller = Get.put(TodoController());
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 280.0;

  var _calendarFormat = CalendarFormat.month;

  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    _navigateAndDisplaySelection(BuildContext context) async {
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TodoAdd(day: controller.selectedDay)),
      );

      if (result?.todo != null && result?.description != null) {
        controller.dateStr =
            DateFormat('yyyy년 MM월 dd일').format(controller.selectedDay);
        controller.addTodoAll(
            ToDoAll(controller.dateStr, result.todo!, result.description!));
        controller.addTodo(ToDos(result.todo!, result.description!));
      }

      print(controller.selectedDay);
      print(controller.focusedDay);

      // print(selectedEvents);
      // print(controller.selectedEvents);
    }

    return GetBuilder<TodoController>(builder: (controller) {
      return Scaffold(
        body: Stack(children: [
          SlidingUpPanel(
            maxHeight: MediaQuery.of(context).size.height / 1.8,
            parallaxEnabled: true,
            parallaxOffset: .5,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            panelBuilder: (sc) => Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black),
              ),
              const Text(
                "일정 보기",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
              Text(
                controller.dateStr,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
              const Todolist()
            ]),
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightClosed - _panelHeightOpen) +
                  _initFabHeight;
            }),
            body: Center(
              child: TableCalendar(
                locale: 'ko_KR',
                firstDay: DateTime(2022, 1, 1),
                lastDay: DateTime(2023, 12, 31),
                focusedDay: controller.focusedDay,
                onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                  // 선택된 날짜의 상태를 갱신합니다.
                  setState(() {
                    controller.selectedDay = selectedDay;
                    controller.focusedDay = focusedDay;

                    controller.dateStr = DateFormat('yyyy년 MM월 dd일')
                        .format(controller.selectedDay);
                  });
                },
                selectedDayPredicate: (DateTime day) {
                  // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
                  return isSameDay(controller.selectedDay, day);
                },
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                calendarStyle: const CalendarStyle(
                  markerSize: 10.0,
                  markerDecoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
                eventLoader: controller.getEventsForDay,
              ),
            ),
          ),
          Positioned(
            right: 20.0,
            bottom: _fabHeight,
            child: FloatingActionButton(
              onPressed: () {
                _navigateAndDisplaySelection(context);
              },
              child: const Icon(Icons.add),
            ),
          ),
        ]),
      );
    });
  }
}

class ToDo {
  bool isDone = false;
  String title;
  String description;

  ToDo(this.title, this.description);
}

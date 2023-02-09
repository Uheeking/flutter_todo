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
import 'package:todo/todolist.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 280.0;

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();
  late String dateStr = '';

  // Map<DateTime, List<ToDo>> selectedEvents = {
  //   DateTime.utc(2023, 1, 11): [
  //     ToDo('title', 'description'),
  //   ],
  // };

  // List<ToDo> _getEventsForDay(DateTime day) {
  //   return selectedEvents[day] ?? [];
  // }

  // void _addTodo(ToDo todo) {
  //   setState(() {
  //     if (selectedEvents[selectedDay] != null) {
  //       selectedEvents[selectedDay]?.add(ToDo(todo.title, todo.description));
  //     } else {
  //       selectedEvents[selectedDay] = [(ToDo(todo.title, todo.description))];
  //     }
  //   });
  // }

  // void _deleteTodo(ToDo todo) {
  //   setState(() {
  //     selectedEvents[selectedDay]?.remove(todo);
  //   });
  // }

  // void _checkTodo(ToDo todo) {
  //   setState(() {
  //     todo.isDone = !todo.isDone;
  //   });
  // }

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
    final controller = Get.put(TodoController());
    _navigateAndDisplaySelection(BuildContext context) async {
      DateTime focusedDay = DateTime.now();
      var result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TodoAdd(day: selectedDay)),
      );

      if (result?.todo != null && result?.description != null) {
        // _addTodo(ToDo(result.todo!, result.description!));
        controller.addTodo(ToDos(result.todo!, result.description!));
      }

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
                dateStr,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
              Todolist()
              // ..._getEventsForDay(selectedDay).map((ToDo todo) => ListTile(
              //     onTap: () {
              //       showDialog(
              //           context: context,
              //           builder: (BuildContext context) {
              //             return AlertDialog(
              //               title: Text(todo.title),
              //               content: SingleChildScrollView(
              //                   child: ListBody(
              //                 children: [
              //                   Text(todo.description),
              //                 ],
              //               )),
              //               actions: [
              //                 ElevatedButton(
              //                     onPressed: () {
              //                       Navigator.of(context).pop();
              //                     },
              //                     child: Text('ok')),
              //               ],
              //             );
              //           });
              //     },
              //     trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              //       IconButton(
              //         color: Colors.blue,
              //         icon: const Icon(Icons.check),
              //         onPressed: () {
              //           _checkTodo(todo);
              //         },
              //       ),
              //       IconButton(
              //           icon: const Icon(Icons.delete),
              //           onPressed: () {
              //             showDialog(
              //                 context: context,
              //                 builder: (BuildContext context) {
              //                   return AlertDialog(
              //                     title: const Text('일정 삭제'),
              //                     content: SingleChildScrollView(
              //                         child: ListBody(
              //                       children: const [
              //                         Text('일정을 삭제하시겠습니까?'),
              //                       ],
              //                     )),
              //                     actions: [
              //                       ElevatedButton(
              //                           onPressed: () {
              //                             _deleteTodo(todo);
              //                             Navigator.of(context).pop();
              //                           },
              //                           child: const Text('ok')),
              //                       ElevatedButton(
              //                           onPressed: () {
              //                             Navigator.of(context).pop();
              //                           },
              //                           child: const Text('cancel'))
              //                     ],
              //                   );
              //                 });
              //           })
              //     ]),
              //     title: Text(todo.title,
              //         style: todo.isDone
              //             ? const TextStyle(
              //                 decoration: TextDecoration.lineThrough,
              //                 fontStyle: FontStyle.italic)
              //             : null)))
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
                focusedDay: focusedDay,
                onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                  // 선택된 날짜의 상태를 갱신합니다.
                  setState(() {
                    this.selectedDay = selectedDay;
                    this.focusedDay = focusedDay;

                    controller.selectedDay = selectedDay;
                    controller.focusedDay = focusedDay;

                    dateStr = DateFormat('yyyy년 MM월 dd일').format(selectedDay);
                  });
                },
                selectedDayPredicate: (DateTime day) {
                  // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
                  return isSameDay(selectedDay, day);
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

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/pages/todoAdd.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 400.0;

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();
  late String dateStr = '';

  Map<DateTime, List<Event>> selectedEvents = {
    DateTime.utc(2023, 1, 11): [Event('title'), Event('title2')],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return selectedEvents[day] ?? [];
  }

  final _items = <ToDo>[];

  void _addTodo(ToDo todo) {
    setState(() {
      _items.add(todo);
    });
  }

  void _deleteTodo(ToDo todo) {
    setState(() {
      _items.remove(todo);
    });
  }

  void _checkTodo(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  var _calendarFormat = CalendarFormat.month;

  _navigateAndDisplaySelection(BuildContext context) async {
    DateTime focusedDay = DateTime.now();
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoAdd(day: selectedDay)),
    );

    if (result?.todo != null && result?.description != null) {
      _addTodo(ToDo(result.todo!, result.description!));
    }
  }

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Todo List',
        ),
      ),
      body: Stack(children: [
        SlidingUpPanel(
          parallaxEnabled: true,
          parallaxOffset: .5,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
          panelBuilder: (sc) => Column(children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              width: 70,
              height: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.black),
            ),
            // const SizedBox(
            //   height: 12.0,
            // ),
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
            ListView.builder(
              itemCount: _items.length,
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  onTap: () {
                    _checkTodo(_items[index]);
                  },
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                      color: Colors.blue,
                      icon: Icon(Icons.check),
                      onPressed: () {
                        _checkTodo(_items[index]);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteTodo(_items[index]);
                      },
                    ),
                  ]),
                  title: Text(
                    _items[index].title,
                    style: _items[index].isDone
                        ? TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontStyle: FontStyle.italic)
                        : null,
                  ),
                );
              },
              shrinkWrap: true,
            ),
          ]),
          onPanelSlide: (double pos) => setState(() {
            _fabHeight =
                pos * (_panelHeightClosed - _panelHeightOpen) + _initFabHeight;
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
                  this.dateStr =
                      DateFormat('yyyy년 MM월 dd일').format(selectedDay);
                });
                print(selectedDay);
                print(selectedEvents[selectedDay]);
              },
              selectedDayPredicate: (DateTime day) {
                // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
                return isSameDay(selectedDay, day);
              },
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                print(format);
                setState(() {
                  _calendarFormat = format;
                });
              },
              calendarStyle: CalendarStyle(
                markerSize: 10.0,
                markerDecoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
              eventLoader: _getEventsForDay,
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
            child: Icon(Icons.add),
          ),
        ),
      ]),
    );
  }
}

class Event {
  bool isDone = false;
  String title;

  Event(this.title);
}

class ToDo {
  bool isDone = false;
  String title;
  String description;

  ToDo(this.title, this.description);
}

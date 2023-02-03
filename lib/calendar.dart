import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/pages/todoAdd.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

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

  void _toggleTodo(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  Map<DateTime, List<Event>> events = {
    DateTime.utc(2023, 1, 11): [Event('title'), Event('title2')],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  var _calendarFormat = CalendarFormat.month;

  _navigateAndDisplaySelection(BuildContext context) async {
    DateTime focusedDay = DateTime.now();
    Datas result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoAdd(day: focusedDay)),
    );
    // print(result.todo);
    _addTodo(ToDo(result.todo!, result.description!));

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('새로운 일정이 추가되었습니다. ')));
  }

  Widget _buildItemWidget(ToDo todo) {
    return ListTile(
      onTap: () {
        _toggleTodo(todo);
      },
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
          color: Colors.blue,
          icon: Icon(Icons.check),
          onPressed: () {
            _toggleTodo(todo);
          },
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            _deleteTodo(todo);
          },
        ),
      ]),
      title: Text(
        todo.title,
        style: todo.isDone
            ? TextStyle(
                decoration: TextDecoration.lineThrough,
                fontStyle: FontStyle.italic)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Todo List',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          TableCalendar(
            locale: 'ko_KR',
            firstDay: DateTime(2022, 1, 1),
            lastDay: DateTime(2023, 12, 31),
            focusedDay: focusedDay,
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              // 선택된 날짜의 상태를 갱신합니다.
              setState(() {
                this.selectedDay = selectedDay;
                this.focusedDay = focusedDay;
              });
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
          ListView(
            shrinkWrap: true,
            children: _items.map((todo) => _buildItemWidget(todo)).toList(),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateAndDisplaySelection(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Event {
  String title;

  Event(this.title);
}

class ToDo {
  bool isDone = false;
  String title;
  String description;

  ToDo(this.title, this.description);
}

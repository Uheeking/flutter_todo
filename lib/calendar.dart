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

  final myController = TextEditingController();
  final _items = <ToDo>[];

  void _addTodo(ToDo todo) {
    setState(() {
      _items.add(todo);
    });
  }

  @override
  void initState() {
    super.initState();
    // myController에 리스너 추가
    myController.addListener(_printLatestValue);
  }

  // _MyCustomFormState가 제거될 때 호출
  @override
  void dispose() {
    // 텍스트에디팅컨트롤러를 제거하고, 등록된 리스너도 제거된다.
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print("Second text field: ${myController.text}");
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
    // Navigator.push는 Future를 반환합니다. Future는 선택 창에서
    // Navigator.pop이 호출된 이후 완료될 것입니다.
    Datas result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoAdd(day: focusedDay)),
    );
    print(result.todo);
    _addTodo(ToDo(result.todo!, result.description!));
    // _addTodo(result.todo, result.description);

    // 선택 창으로부터 결과 값을 받은 후, 이전에 있던 snackbar는 숨기고 새로운 결과 값을
    // 보여줍니다.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(result.todo!)));
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

Widget _buildItemWidget(ToDo todo) {
  return ListTile(
    onTap: () {},
    trailing: IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {},
    ),
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

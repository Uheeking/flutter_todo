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

  Map<DateTime, List<Event>> events = {
    DateTime.utc(2023, 1, 11): [Event('title'), Event('title2')],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  var _calendarFormat = CalendarFormat.month;

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
      ),

      floatingActionButton: SelectionButton(),
      // FloatingActionButton(
      //   onPressed: () {},
      // child: Icon(Icons.add),
      // ),
    );
  }
}

class SelectionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: Icon(Icons.add),
    );
  }

  // SelectionScreen을 띄우고 navigator.pop으로부터 결과를 기다리는 메서드
  _navigateAndDisplaySelection(BuildContext context) async {
    DateTime focusedDay = DateTime.now();
    // Navigator.push는 Future를 반환합니다. Future는 선택 창에서
    // Navigator.pop이 호출된 이후 완료될 것입니다.
    final Map<String, String> result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoAdd(day: focusedDay)),
    );
    var todo = result['todo'];
    var description = result['description'];

    // 선택 창으로부터 결과 값을 받은 후, 이전에 있던 snackbar는 숨기고 새로운 결과 값을
    // 보여줍니다.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$todo")));
  }
}

class Event {
  String title;

  Event(this.title);
}

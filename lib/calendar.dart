import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Map<DateTime, List<Event>> events = {
    DateTime.utc(2023, 1, 11): [Event('title'), Event('title2')],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  var _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TableCalendar(
        locale: 'ko_KR',
        focusedDay: DateTime.now(),
        firstDay: DateTime(2022, 1, 1),
        lastDay: DateTime(2023, 12, 31),
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
    );
  }
}

class Event {
  String title;

  Event(this.title);
}

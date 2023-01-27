import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  var _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
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
    );
  }
}

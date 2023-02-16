import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class ToDoAll {
  bool isDone = false;
  DateTime changeDay; //datepicker 일자
  DateTime day; //선택한 월일
  String time; //년월일
  String title;
  String description;

  ToDoAll(this.changeDay, this.day, this.time, this.title, this.description);
}

class ToDos {
  bool isDone = false;
  // DateTime day;
  String title;
  String description;

  ToDos(this.title, this.description);
}

class TodoController extends GetxController {
  // ignore: prefer_typing_uninitialized_variables
  var datechange;
  Map<DateTime, List<ToDos>> selectedEvents = {};
  var todayList = [];
  final items = <ToDoAll>[];
  List<ToDos> getEventsForDay(DateTime day) {
    return selectedEvents[day] ?? [];
  }

  // late DateTime day;
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();
  late DateTime changeDay;
  late String dateStr = '';

  void addTodoAll(ToDoAll todoall) {
    items.add(todoall);
    update();
  }

  void deleteTodoAll(index) {
    for (var i = 0; i < items.length; i++) {
      if (selectedEvents[selectedDay]![index].title == items[i].title) {
        if (selectedEvents[selectedDay]![index].description ==
            items[i].description) {
          items.removeAt(i);
        }
      }
    }
    update();
  }

  void deleteTodoAll2(index) {
    items.removeAt(index);
    update();
  }

  void checkTodoAll(index, isDone) {
    for (var i = 0; i < items.length; i++) {
      if (selectedEvents[selectedDay]![index].title == items[i].title) {
        if (selectedEvents[selectedDay]![index].description ==
            items[i].description) {
          items[i].isDone = isDone;
        }
      }
    }
    update();
  }

  void checkTodoAll2(index, isDone) {
    items[index].isDone = isDone;
    update();
  }

  void addTodo(ToDos todo, date) {
    print(date.toString() + 'addtodo');
    DateTime day = DateTime.utc(
      date.year,
      date.month,
      date.day,
    );
    if (selectedEvents[day] != null) {
      selectedEvents[day]?.add(ToDos(todo.title, todo.description));
    } else {
      selectedEvents[day] = [(ToDos(todo.title, todo.description))];
    }
    update();
  }

  void deleteTodo(index) {
    selectedEvents[selectedDay]?.removeAt(index);
    update();
  }

  void deleteTodo2(day, index) {
    int? num = selectedEvents[day]?.length;
    for (var i = 0; i < num!; i++) {
      if (selectedEvents[day]![i].title == items[index].title) {
        if (selectedEvents[day]![i].description == items[index].description) {
          selectedEvents[day]?.removeAt(i);
        }
      }
    }
    update();
  }

  void checkTodo(index, isDone) {
    selectedEvents[selectedDay]![index].isDone = !isDone;
    update();
  }

  void checkTodo2(date, index, isDone) {
    DateTime day = DateTime.utc(
      date.year,
      date.month,
      date.day,
    );
    int? num = selectedEvents[day]?.length;
    for (var i = 0; i < num!; i++) {
      if (selectedEvents[day]![i].title == items[index].title) {
        if (selectedEvents[day]![i].description == items[index].description) {
          selectedEvents[day]![i].isDone = !isDone;
        }
      }
    }
    update();
  }
}

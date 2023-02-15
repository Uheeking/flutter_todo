import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class ToDoAll {
  bool isDone = false;
  int count;
  String time;
  String title;
  String description;

  ToDoAll(this.count, this.time, this.title, this.description);
}

class ToDos {
  bool isDone = false;
  int count;
  String title;
  String description;

  ToDos(this.count, this.title, this.description);
}

class TodoController extends GetxController {
  int count = 0;
  int delcount = 0;
  Map<DateTime, List<ToDos>> selectedEvents = {};
  var todayList = [];
  final items = <ToDoAll>[];
  List<ToDos> getEventsForDay(DateTime day) {
    return selectedEvents[day] ?? [];
  }

  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();
  late String dateStr = '';

  void addTodoAll(ToDoAll todoall) {
    items.add(todoall);
    update();
  }

  void deleteTodoAll(ToDoAll todoall) {
    var count = items.length - delcount;
    if (delcount == 0) {
      items.removeAt(todoall.count);
    } else {
      items.removeAt(count);
    }
    update();
  }

  void deleteTodoAll2(ToDoAll todoall) {
    items.remove(todoall);
    update();
  }

  void checkTodoAll(count, isDone) {
    items[count].isDone = isDone;
    update();
  }

  void checkTodoAll2(count, isDone) {
    items[count].isDone = !isDone;
    update();
  }

  void addTodo(ToDos todo) {
    if (selectedEvents[selectedDay] != null) {
      selectedEvents[selectedDay]
          ?.add(ToDos(todo.count, todo.title, todo.description));
    } else {
      selectedEvents[selectedDay] = [
        (ToDos(todo.count, todo.title, todo.description))
      ];
    }
    update();
  }

  void deleteTodo(ToDos todo) {
    selectedEvents[selectedDay]?.remove(todo);
    print(selectedEvents);
    update();
  }

  void checkTodo(ToDos todo) {
    todo.isDone = !todo.isDone;
    update();
  }

  void checkTodo2(ToDos todo, isDone) {
    selectedEvents[selectedDay]?.elementAt(0).isDone = !isDone;
    update();
  }
}

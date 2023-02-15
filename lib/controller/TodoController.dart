import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class ToDoAll {
  bool isDone = false;
  int count;
  DateTime day = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  String time;
  String title;
  String description;

  ToDoAll(this.count, this.day, this.time, this.title, this.description);
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
  Map<DateTime, List<ToDos>> selectedEvents = {};
  var todayList = [];
  var content = [];
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
  late String date = '';
  late String dateStr = '';

  eventList(day, dateformat) {
    for (var i in todayList) {
      if (dateformat.format(day) == i.date) {
        return i.title;
      }
    }
    return [];
  }

  void addTodoAll(ToDoAll todoall) {
    items.add(todoall);
    // count = count + 1;
    print(items.toString() + ' addtodoall');
    update();
  }

  void deleteTodoAll(ToDoAll todoall) {
    items.remove(todoall);
    print(selectedEvents);
    print(items);
    update();
  }

  void checkTodoAll(count, isDone) {
    items[count].isDone = isDone;
    print(count);
    print('checkTodoall');
    print(isDone);
    update();
  }

  void checkTodoAll2(count, isDone) {
    items[count].isDone = !isDone;
    print(count);
    print('checkTodoall');
    print(isDone);
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
    print('$selectedEvents addtodo');
    print(todo.title + todo.description);
    update();
  }

  void deleteTodo(ToDos todo) {
    selectedEvents[selectedDay]?.remove(todo);
    print(selectedEvents);
    update();
  }

  void checkTodo(ToDos todo) {
    // selectedEvents[selectedEvents]?.isDone = !isDone;
    todo.isDone = !todo.isDone;
    print('checkTodo');
    // print(isDone);
    print(selectedDay);
    print(selectedEvents[selectedDay]?.elementAt(0).title);
    // print(todo);
    update();
  }

  void checkTodo2(ToDos todo, isDone) {
    // todo.isDone = !todo.isDone;
    selectedEvents[selectedDay]?.elementAt(0).isDone = !isDone;
    print('checkTodo');
    print(!isDone);
    print(selectedEvents[selectedDay]?.elementAt(0).isDone);
    // print(todo);
    update();
  }
}

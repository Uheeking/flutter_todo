import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class ToDoAll {
  bool isDone = false;
  DateTime day;
  String time;
  String title;
  String description;

  ToDoAll(this.day, this.time, this.title, this.description);
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
  late int todoIndex;
  late int todoallIndex;
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

  void deleteTodo(index) {
    selectedEvents[selectedDay]?.removeAt(index);
    update();
  }

  // void deleteTodo2(index) {
  //   for (var i = 0; i < items.length; i++) {
  //     if (selectedEvents[selectedDay]![i].title == items[index].title) {
  //       if (selectedEvents[selectedDay]![i].description ==
  //           items[index].description) {
  //         selectedEvents[selectedDay]?.removeAt(index);
  //       }
  //     }
  //   }
  //   update();
  // }

  void checkTodo(index, isDone) {
    selectedEvents[selectedDay]![index].isDone = !isDone;
    update();
  }

  void checkTodo2(day, index, isDone) {
    print(index);
    int? num = selectedEvents[day]?.length;
    for (var i = 0; i < num!; i++) {
      if (selectedEvents[day]![i].title == items[index].title) {
        if (selectedEvents[day]![i].description == items[index].description) {
          selectedEvents[day]![i].isDone = !isDone;
          print(selectedEvents[selectedDay]![i].title);
        }
      }
    }
    update();
  }
}

import 'package:get/get.dart';

class ToDoAll {
  bool isDone = false;
  String time;
  String title;
  String description;

  ToDoAll(this.time, this.title, this.description);
}

class ToDos {
  bool isDone = false;
  String title;
  String description;

  ToDos(this.title, this.description);
}

class TodoController extends GetxController {
  Map<DateTime, List<ToDos>> selectedEvents = {};
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

  void addTodoAll(ToDoAll todo) {
    items.add(todo);
    print(items.toString() + 'addtodoall');
    update();
  }

  void addTodo(ToDos todo) {
    if (selectedEvents[selectedDay] != null) {
      selectedEvents[selectedDay]?.add(ToDos(todo.title, todo.description));
    } else {
      selectedEvents[selectedDay] = [(ToDos(todo.title, todo.description))];
    }
    print(selectedEvents.toString() + ' sssss');
    update();
  }

  void deleteTodo(ToDos todo) {
    selectedEvents[selectedDay]?.remove(todo);
    print(selectedEvents);
    update();
  }

  void checkTodo(ToDos todo) {
    todo.isDone = !todo.isDone;
    print(selectedEvents);
    update();
  }
}

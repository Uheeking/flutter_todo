import 'package:get/get.dart';

class ToDos {
  bool isDone = false;
  String title;
  String description;

  ToDos(this.title, this.description);
}

class TodoController extends GetxController {
  DateTime focusedDay = DateTime.now();
  Map<DateTime, List<ToDos>> selectedEvents = {};
  List<ToDos> getEventsForDay(DateTime day) {
    return selectedEvents[day] ?? [];
  }

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  void addTodo(ToDos todo) {
    if (selectedEvents[selectedDay] != null) {
      selectedEvents[selectedDay]?.add(ToDos(todo.title, todo.description));
    } else {
      selectedEvents[selectedDay] = [(ToDos(todo.title, todo.description))];
    }
    print(selectedEvents);
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

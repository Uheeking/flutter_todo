import 'package:get/get.dart';

class ToDos {
  bool isDone = false;
  String title;
  String description;

  ToDos(this.title, this.description);
}

class TodoController extends GetxController {
  String uhee = 'uhee';
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
    update();
  }

  void deleteTodo(ToDos todo) {
    selectedEvents[selectedDay]?.remove(todo);
    update();
  }

  void checkTodo(ToDos todo) {
    todo.isDone = !todo.isDone;
    update();
  }
}

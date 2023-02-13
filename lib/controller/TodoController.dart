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
  late String dateStr = '';
  // indexOf

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

  void addTodo(ToDos todo) {
    if (selectedEvents[selectedDay] != null) {
      selectedEvents[selectedDay]
          ?.add(ToDos(todo.count, todo.title, todo.description));
    } else {
      selectedEvents[selectedDay] = [
        (ToDos(todo.count, todo.title, todo.description))
      ];
    }
    print(selectedEvents.toString() + ' addtodo');
    print(todo.title + todo.description);
    update();
  }

  void deleteTodo(ToDos todo) {
    selectedEvents[selectedDay]?.remove(todo);
    print(selectedEvents);
    update();
  }

  void checkTodo(ToDos todo) {
    todo.isDone = !todo.isDone;
    print('checkTodo');
    print(todo.isDone);
    update();
  }
}

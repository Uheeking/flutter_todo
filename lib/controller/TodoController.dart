import 'package:get/get.dart';

class ToDo {
  bool isDone = false;
  String title;
  String description;

  ToDo(this.title, this.description);
}

class TodoController extends GetxController {
  Map<DateTime, List<ToDo>> selectedEvents = {};
}

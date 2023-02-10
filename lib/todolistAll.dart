import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo/controller/TodoController.dart';
import 'package:get/get.dart';

class TodolistAll extends StatelessWidget {
  const TodolistAll({super.key});

  @override
  Widget build(BuildContext context) {
    final controTodo = Get.put(TodoController());

    return GetBuilder<TodoController>(builder: (controller) {
      return Container(
        child: Column(children: [
          ...controTodo.items.map((ToDoAll todo) => ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(todo.title),
                        content: SingleChildScrollView(
                            child: ListBody(
                          children: [
                            Text(todo.description),
                            // Text(todo.),
                          ],
                        )),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('ok')),
                        ],
                      );
                    });
              },
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                  color: Colors.blue,
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    // controTodo.checkTodo(todo);
                  },
                ),
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('일정 삭제'),
                              content: SingleChildScrollView(
                                  child: ListBody(
                                children: const [
                                  Text('일정을 삭제하시겠습니까?'),
                                ],
                              )),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      // controTodo.deleteTodo(todo);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('ok')),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('cancel'))
                              ],
                            );
                          });
                    })
              ]),
              title: Text(todo.title,
                  style: todo.isDone
                      ? const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontStyle: FontStyle.italic)
                      : null))),
          ]),
      );
    });
  }
}

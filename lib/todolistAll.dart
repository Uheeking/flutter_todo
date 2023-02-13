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
      return controTodo.items.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '일정이 없습니다. ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Text('일정을 추가하시려면 캘린더탭에 들어가 추가해주세요.')
              ],
            )
          : Column(children: [
              ...controTodo.items.map((ToDoAll todoall) => (ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(todoall.title),
                            content: SingleChildScrollView(
                                child: ListBody(
                              children: [
                                Text(todoall.description),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text('${todoall.time}에 작성'),
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
                        //         controTodo.checkTodoAll(
                        //             todo.count, todo.isDone);
                        controTodo.checkTodo(todoall.day, todoall.isDone);
                        controTodo.checkTodoAll(todoall.count, todoall.isDone);
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
                                          controTodo.deleteTodoAll(todoall);
                                          // controTodo.deleteTodo(ToDos(
                                          //     todoall.title,
                                          //     todoall.description));
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
                  title: Text(todoall.title,
                      style: todoall.isDone
                          ? const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontStyle: FontStyle.italic)
                          : null))))
            ]);
    });
  }
}

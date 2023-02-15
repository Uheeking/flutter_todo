import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo/controller/TodoController.dart';
import 'package:get/get.dart';

class Todolist extends StatelessWidget {
  const Todolist({super.key, required this.day, required this.time});
  final DateTime day;
  final String time;

  @override
  Widget build(BuildContext context) {
    final controTodo = Get.put(TodoController());
    final itemList = controTodo.selectedEvents[controTodo.selectedDay];

    return GetBuilder<TodoController>(builder: (controller) {
      return controTodo.selectedEvents[controTodo.selectedDay]?.length == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '일정이 없습니다. ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Text('일정을 추가해주세요.')
              ],
            )
          : Column(mainAxisSize: MainAxisSize.min, children: [
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      controTodo.selectedEvents[controTodo.selectedDay]?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(itemList.elementAt(index).title),
                                  content: SingleChildScrollView(
                                      child: ListBody(
                                    children: [
                                      Text(itemList
                                          .elementAt(index)
                                          .description),
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
                        trailing:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                            color: Colors.blue,
                            icon: const Icon(Icons.check),
                            onPressed: () {
                              controTodo.checkTodo(
                                  index, itemList!.elementAt(index).isDone);
                              controTodo.checkTodoAll(
                                  index, itemList.elementAt(index).isDone);
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
                                                controTodo.deleteTodoAll(index);
                                                controTodo.deleteTodo(index);
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
                        // title: const Text('eess'));
                        title: Text(itemList!.elementAt(index).title,
                            style: itemList.elementAt(index).isDone
                                ? const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontStyle: FontStyle.italic)
                                : null));
                  },
                ),
              )
            ]);
      // );
    });
  }
}

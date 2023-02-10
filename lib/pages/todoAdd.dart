import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class TodoAdd extends StatefulWidget {
  final DateTime day;
  const TodoAdd({super.key, required this.day});

  @override
  State<TodoAdd> createState() => _TodoAddState();
}

class _TodoAddState extends State<TodoAdd> {
  final myController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? todo = '';
  String? description = '';

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('yyyy년 MM월 dd일').format(widget.day);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo Add'),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    '할 일',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  decoration: const InputDecoration(hintText: '할 일을 적어주세요.'),
                  onSaved: (val) {
                    setState(() {
                      todo = val;
                    });
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '할 일은 필수사항입니다.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    '설명',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                TextFormField(
                  maxLines: 5,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0)),
                      contentPadding: const EdgeInsets.all(10.0),
                      hintText: '설명을 적어주세요.'),
                  onSaved: (val) {
                    setState(() {
                      description = val;
                    });
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '설명은 필수사항입니다.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    '날짜',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.calendar_today),
                            Text(
                              date,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        // _selectDate(contesxt, state);
                      }),
                ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Container(
                //     width: MediaQuery.of(context).size.width / 2.4,
                //     height: 50,
                //     decoration: BoxDecoration(
                //         border: Border.all(width: 1, color: Colors.grey)),
                //     child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           const Icon(Icons.calendar_today),
                //           Text(
                //             date,
                //             style: const TextStyle(
                //                 fontWeight: FontWeight.bold, fontSize: 16),
                //           )
                //         ]),
                //   ),
                // ),
                const SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      Get.snackbar(
                        '저장완료!',
                        '폼 저장이 완료되었습니다!',
                        backgroundColor: Colors.white,
                      );
                      Navigator.pop(context, Datas(todo!, description!));
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        color: Colors.blue),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add),
                          Text(
                            '새로운 일정 추가하기',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ]),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> _selectDate(BuildContext context, TodoState state) async {
  //   DateTime d = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime(2050),
  //   );

  // selectDate = DateFormat('yyyy-MM-dd').format(d);
  // _todoBloc.add(AddDateChanged(date: selectDate));
  // }
}

class Datas {
  bool isDone = false;
  late String? todo = '';
  late String? description = '';

  Datas(this.todo, this.description);
}

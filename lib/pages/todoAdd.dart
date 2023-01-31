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
  String? name = '';
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
          title: Text('Todo Add'),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '할 일',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    print('myController: $value');
                  },
                  controller: myController,
                  decoration: InputDecoration(hintText: '할 일을 적어주세요.'),
                  onSaved: (val) {
                    setState(() {
                      this.name = val;
                    });
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '할 일은 필수사항입니다.';
                    }
                    if (val.length < 1) {
                      return '할 일은 필수사항입니다.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '설명',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0)),
                      contentPadding: EdgeInsets.all(10.0),
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
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '날짜',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.calendar_today),
                          Text(
                            date,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ]),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(name! + 'uheee' + description!)));
                      print(name);
                      print(description);
                      // validation 이 성공하면 true 가 리턴돼요!
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
                        children: [
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
}

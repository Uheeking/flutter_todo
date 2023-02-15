import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:get/get.dart';
import 'controller/IndexController.dart';

class BottomNavi extends StatefulWidget {
  const BottomNavi({
    super.key,
  });

  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IndexController());

    return Obx(
      () => BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: '캘린더',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: '일정모음',
              backgroundColor: Colors.red,
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.blue,
          onTap: controller.onItemTapped),
    );
  }
}

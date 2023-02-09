import 'package:get/get.dart';

class IndexController extends GetxController {
  // final count = 0.obs;

  // void increment() {
  //   count.value++;
  //   // count(count.value + 1);
  // }
  final selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
    print(index);
  }
}

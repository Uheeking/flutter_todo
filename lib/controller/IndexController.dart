import 'package:get/get.dart';

class IndexController extends GetxController {
  final selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}

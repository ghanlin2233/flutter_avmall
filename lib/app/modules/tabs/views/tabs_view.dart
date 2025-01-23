import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: controller.pages[controller.currentIndex.value],
          bottomNavigationBar: BottomNavigationBar(
              iconSize: 30,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              fixedColor: Colors.blue,
              currentIndex: controller.currentIndex.value,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                controller.setCurrentIndex(value);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: "首页"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline), label: "用户")
              ]),
        ));
  }
}

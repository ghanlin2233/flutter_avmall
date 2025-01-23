import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../modules/home/views/home_view.dart';
import '../../../modules/user/views/user_view.dart';

class TabsController extends GetxController with GetTickerProviderStateMixin{
  late TabController tabController;
  RxInt currentIndex = 0.obs;
  final List<Widget> pages = const [
    HomeView(),
    UserView()
  ];
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: pages.length, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void setCurrentIndex(index){
    currentIndex.value = index;
    update();
  }
}

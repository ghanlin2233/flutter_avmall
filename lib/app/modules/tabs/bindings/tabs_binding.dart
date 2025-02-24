import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../user/controllers/user_controller.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabsController>(
      () => TabsController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<UserController>(
      () => UserController(),
    );
  }
}

import 'package:get/get.dart';
import 'package:grootan_task_app/presentation/controllers/lastlogin/lastlogin_controller.dart';

class LastLoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LastLoginController());
  }
}

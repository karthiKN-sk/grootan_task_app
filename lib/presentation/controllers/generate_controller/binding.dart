import 'package:get/get.dart';
import 'package:grootan_task_app/presentation/controllers/generate_controller/num_generate_controller.dart';

import '../location/location_controller.dart';

class NumberGenerateBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationController());
    Get.lazyPut(() => NumGenerateController());
  }
}

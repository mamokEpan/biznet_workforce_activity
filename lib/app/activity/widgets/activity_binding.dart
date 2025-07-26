import 'package:biznet_workforce_activity/app/activity/controllers/activity_controller.dart';
import 'package:get/get.dart';


class ActivityFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityFormController>(
      () => ActivityFormController(),
    );
  }
}
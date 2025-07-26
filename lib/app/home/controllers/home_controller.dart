import 'package:biznet_workforce_activity/app/activity/views/activity_view.dart';
import 'package:biznet_workforce_activity/models/home/activity_model.dart';
import 'package:biznet_workforce_activity/services/activity_provider.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ActivityProvider _activityProvider = ActivityProvider();
  RxList<Activity> activities = <Activity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _activityProvider.getActivities().listen((data) {
      activities.assignAll(data);
    });
  }

  void navigateToAddActivity() {
    Get.to(() => const ActivityFormView());
  }

  void navigateToEditActivity(Activity activity) {
    Get.to(() => const ActivityFormView(), arguments: activity);
  }

  Future<void> deleteActivity(String activityId) async {
    Get.defaultDialog(
      title: "Hapus Aktivitas",
      middleText: "Apakah Anda yakin ingin menghapus aktivitas ini?",
      textConfirm: "Hapus",
      textCancel: "Batal",
      confirmTextColor: Get.theme.canvasColor,
      onConfirm: () async {
        await _activityProvider.deleteActivity(activityId);
        Get.back(); // Tutup dialog
        Get.snackbar("Sukses", "Aktivitas berhasil dihapus");
      },
    );
  }

  Future<void> markAsCompleted(String activityId) async {
    await _activityProvider.markActivityAsCompleted(activityId);
    Get.snackbar("Sukses", "Aktivitas berhasil ditandai selesai");
  }
}

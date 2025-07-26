import 'package:biznet_workforce_activity/models/home/activity_model.dart';
import 'package:biznet_workforce_activity/services/activity_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';


class ActivityFormController extends GetxController {
  final ActivityProvider _activityProvider = ActivityProvider();
  final Rx<Activity?> currentActivity = Rx<Activity?>(null);

  final TextEditingController judulController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final RxString longLat = ''.obs;
  final Rx<DateTime?> jamMulai = Rx<DateTime?>(null);
  final Rx<DateTime?> jamSelesai = Rx<DateTime?>(null);
  final RxString selectedPrioritas = 'Rendah'.obs;
  final RxString selectedStatus = 'Belum Selesai'.obs; // Default status

  final List<String> prioritasOptions = ['Rendah', 'Sedang', 'Tinggi'];
  final List<String> statusOptions = ['Belum Selesai', 'Selesai', 'Dibatalkan']; // Contoh status

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Activity) {
      currentActivity.value = Get.arguments as Activity;
      _fillFormWithActivityData(currentActivity.value!);
    }
  }

  void _fillFormWithActivityData(Activity activity) {
    judulController.text = activity.judul;
    deskripsiController.text = activity.deskripsi;
    lokasiController.text = activity.lokasi;
    longLat.value = activity.longLat;
    jamMulai.value = activity.jamMulai;
    jamSelesai.value = activity.jamSelesai;
    selectedPrioritas.value = activity.prioritas;
    selectedStatus.value = activity.status;
  }

  Future<void> pickDateTime(BuildContext context, {required bool isStartTime}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: (isStartTime ? jamMulai.value : jamSelesai.value) ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          (isStartTime ? jamMulai.value : jamSelesai.value) ?? DateTime.now(),
        ),
      );

      if (pickedTime != null) {
        final fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        if (isStartTime) {
          jamMulai.value = fullDateTime;
        } else {
          jamSelesai.value = fullDateTime;
        }
      }
    }
  }

  Future<void> captureLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Error", "Layanan lokasi dinonaktifkan.");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Error", "Izin lokasi ditolak.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Error", "Izin lokasi ditolak secara permanen. Silakan ubah di pengaturan aplikasi.");
      return;
    }

    Get.snackbar("Informasi", "Mengambil lokasi...", showProgressIndicator: true);
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      longLat.value = "${position.latitude},${position.longitude}";
      Get.closeCurrentSnackbar();
      Get.snackbar("Sukses", "Lokasi berhasil diambil: ${longLat.value}");
    } catch (e) {
      Get.closeCurrentSnackbar();
      Get.snackbar("Error", "Gagal mengambil lokasi: $e");
    }
  }

  Future<void> saveActivity() async {
    if (judulController.text.isEmpty ||
        deskripsiController.text.isEmpty ||
        lokasiController.text.isEmpty ||
        longLat.value.isEmpty ||
        jamMulai.value == null ||
        jamSelesai.value == null) {
      Get.snackbar("Peringatan", "Semua kolom wajib diisi!");
      return;
    }

    if (jamMulai.value!.isAfter(jamSelesai.value!)) {
      Get.snackbar("Peringatan", "Jam mulai tidak boleh setelah jam selesai!");
      return;
    }

    Get.snackbar("Informasi", "Menyimpan aktivitas...", showProgressIndicator: true);

    final now = DateTime.now();
    final activity = Activity(
      id: currentActivity.value?.id,
      judul: judulController.text,
      deskripsi: deskripsiController.text,
      lokasi: lokasiController.text,
      longLat: longLat.value,
      jamMulai: jamMulai.value!,
      jamSelesai: jamSelesai.value!,
      status: selectedStatus.value,
      prioritas: selectedPrioritas.value,
      timestampCreated: currentActivity.value?.timestampCreated ?? now,
      timestampUpdated: now,
    );

    try {
      if (currentActivity.value == null) {
        await _activityProvider.addActivity(activity);
        Get.closeCurrentSnackbar();
        Get.snackbar("Sukses", "Aktivitas berhasil ditambahkan");
      } else {
        await _activityProvider.updateActivity(activity);
        Get.closeCurrentSnackbar();
        Get.snackbar("Sukses", "Aktivitas berhasil diperbarui");
      }
      Get.back(); // Kembali ke halaman sebelumnya
    } catch (e) {
      Get.closeCurrentSnackbar();
      Get.snackbar("Error", "Gagal menyimpan aktivitas: $e");
    }
  }

  @override
  void onClose() {
    judulController.dispose();
    deskripsiController.dispose();
    lokasiController.dispose();
    super.onClose();
  }
}
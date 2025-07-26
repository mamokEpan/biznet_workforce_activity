import 'package:biznet_workforce_activity/app/activity/controllers/activity_controller.dart';
import 'package:biznet_workforce_activity/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ActivityFormView extends GetView<ActivityFormController> {
  
  const ActivityFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.currentActivity.value == null ? "Tambah Aktivitas" : "Edit Aktivitas"),
        backgroundColor: BiznetColors.primaryBlue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputField(
              controller: controller.judulController,
              label: "Judul Aktivitas",
              hint: "Masukkan judul pekerjaan (e.g., Perbaikan Router)",
              icon: Icons.title,
            ),
            const SizedBox(height: 16),
            _buildInputField(
              controller: controller.deskripsiController,
              label: "Deskripsi",
              hint: "Detail pekerjaan yang dilakukan",
              icon: Icons.description,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 16),
            _buildInputField(
              controller: controller.lokasiController,
              label: "Lokasi",
              hint: "Alamat lokasi kerja",
              icon: Icons.location_on,
            ),
            const SizedBox(height: 16),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.longLat.value.isEmpty
                              ? "LongLat: Belum diambil"
                              : "LongLat: ${controller.longLat.value}",
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      IconButton(
                        onPressed: () => controller.captureLocation(),
                        icon: const Icon(Icons.gps_fixed, color: BiznetColors.primaryBlue),
                        tooltip: 'Ambil Lokasi Sekarang',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Catatan: Lokasi (long_lat) akan diambil saat menyimpan atau mengedit.",
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => _buildDateTimePicker(
                context,
                label: "Jam Mulai",
                selectedDateTime: controller.jamMulai.value,
                onTap: () => controller.pickDateTime(context, isStartTime: true),
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => _buildDateTimePicker(
                context,
                label: "Jam Selesai",
                selectedDateTime: controller.jamSelesai.value,
                onTap: () => controller.pickDateTime(context, isStartTime: false),
              ),
            ),
            const SizedBox(height: 16),
            _buildDropdownField(
              label: "Prioritas",
              value: controller.selectedPrioritas.value,
              items: controller.prioritasOptions,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.selectedPrioritas.value = newValue;
                }
              },
              icon: Icons.bar_chart,
            ),
            const SizedBox(height: 16),
            _buildDropdownField(
              label: "Status",
              value: controller.selectedStatus.value,
              items: controller.statusOptions,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.selectedStatus.value = newValue;
                }
              },
              icon: Icons.info_outline,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => controller.saveActivity(),
                icon: const Icon(Icons.save),
                label: Text(controller.currentActivity.value == null ? "Simpan Aktivitas" : "Perbarui Aktivitas"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BiznetColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: BiznetColors.primaryBlue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: BiznetColors.primaryBlue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: BiznetColors.primaryBlue.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: BiznetColors.primaryBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }

  Widget _buildDateTimePicker(
    BuildContext context, {
    required String label,
    required DateTime? selectedDateTime,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.calendar_today, color: BiznetColors.primaryBlue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: BiznetColors.primaryBlue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: BiznetColors.primaryBlue.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: BiznetColors.primaryBlue, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
        child: Text(
          selectedDateTime == null
              ? "Pilih Tanggal dan Waktu"
              : DateFormat('dd MMM yyyy HH:mm').format(selectedDateTime),
          style: TextStyle(
            fontSize: 16,
            color: selectedDateTime == null ? Colors.grey[700] : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required IconData icon,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: BiznetColors.primaryBlue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: BiznetColors.primaryBlue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: BiznetColors.primaryBlue.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: BiznetColors.primaryBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.arrow_drop_down, color: BiznetColors.primaryBlue),
          isExpanded: true,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val),
            );
          }).toList(),
        ),
      ),
    );
  }
}
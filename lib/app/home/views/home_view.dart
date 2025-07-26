import 'package:biznet_workforce_activity/app/home/controllers/home_controller.dart';
import 'package:biznet_workforce_activity/utils/const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Biznet Workforce Activity"),
        backgroundColor: BiznetColors.primaryBlue,
        centerTitle: true,
        // Tambahkan logo Biznet di AppBar jika diinginkan
        // leading: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Image.asset('assets/icons/biznet_logo.png', height: 40),
        // ),
      ),
      body: Obx(
        () => controller.activities.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment, size: 80, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      "Belum ada aktivitas. Tambahkan sekarang!",
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: controller.activities.length,
                itemBuilder: (context, index) {
                  final activity = controller.activities[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: activity.status == 'Selesai'
                            ? BiznetColors.successGreen.withOpacity(0.7)
                            : BiznetColors.primaryBlue.withOpacity(0.7),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity.judul,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: BiznetColors.darkGray,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            activity.deskripsi,
                            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Divider(height: 20, thickness: 1),
                          _buildInfoRow(
                            Icons.location_on,
                            activity.lokasi,
                          ),
                          _buildInfoRow(
                            Icons.timer,
                            '${DateFormat('dd MMM yyyy HH:mm').format(activity.jamMulai)} - ${DateFormat('HH:mm').format(activity.jamSelesai)}',
                          ),
                          _buildInfoRow(
                            Icons.check_circle_outline,
                            'Status: ${activity.status}',
                            color: activity.status == 'Selesai'
                                ? BiznetColors.successGreen
                                : BiznetColors.dangerRed,
                          ),
                          _buildInfoRow(
                            Icons.priority_high,
                            'Prioritas: ${activity.prioritas}',
                            color: activity.prioritas == 'Tinggi'
                                ? BiznetColors.dangerRed
                                : activity.prioritas == 'Sedang'
                                    ? BiznetColors.accentOrange
                                    : Colors.grey[600],
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (activity.status != 'Selesai')
                                  IconButton(
                                    icon: const Icon(Icons.check_circle, color: BiznetColors.successGreen),
                                    tooltip: 'Tandai Selesai',
                                    onPressed: () => controller.markAsCompleted(activity.id!),
                                  ),
                                IconButton(
                                  icon: const Icon(Icons.edit, color: BiznetColors.primaryBlue),
                                  tooltip: 'Edit',
                                  onPressed: () => controller.navigateToEditActivity(activity),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: BiznetColors.dangerRed),
                                  tooltip: 'Hapus',
                                  onPressed: () => controller.deleteActivity(activity.id!),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.navigateToAddActivity(),
        backgroundColor: BiznetColors.accentOrange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color ?? Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13, color: color ?? Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  String? id;
  String judul;
  String deskripsi;
  String lokasi;
  String longLat;
  DateTime jamMulai;
  DateTime jamSelesai;
  String status;
  String prioritas;
  DateTime timestampCreated;
  DateTime timestampUpdated;

  Activity({
    this.id,
    required this.judul,
    required this.deskripsi,
    required this.lokasi,
    required this.longLat,
    required this.jamMulai,
    required this.jamSelesai,
    required this.status,
    required this.prioritas,
    required this.timestampCreated,
    required this.timestampUpdated,
  });

  factory Activity.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Activity(
      id: doc.id,
      judul: data['judul'] ?? '',
      deskripsi: data['deskripsi'] ?? '',
      lokasi: data['lokasi'] ?? '',
      longLat: data['long_lat'] ?? '',
      jamMulai: (data['jam_mulai'] as Timestamp).toDate(),
      jamSelesai: (data['jam_selesai'] as Timestamp).toDate(),
      status: data['status'] ?? 'Belum Selesai',
      prioritas: data['prioritas'] ?? 'Rendah',
      timestampCreated: (data['timestamp_created'] as Timestamp).toDate(),
      timestampUpdated: (data['timestamp_updated'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'judul': judul,
      'deskripsi': deskripsi,
      'lokasi': lokasi,
      'long_lat': longLat,
      'jam_mulai': Timestamp.fromDate(jamMulai),
      'jam_selesai': Timestamp.fromDate(jamSelesai),
      'status': status,
      'prioritas': prioritas,
      'timestamp_created': Timestamp.fromDate(timestampCreated),
      'timestamp_updated': Timestamp.fromDate(timestampUpdated),
    };
  }
}
import 'package:biznet_workforce_activity/models/home/activity_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _collectionName = 'activities';

  Stream<List<Activity>> getActivities() {
    return _db.collection(_collectionName).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Activity.fromFirestore(doc)).toList();
    });
  }

  Future<void> addActivity(Activity activity) async {
    await _db.collection(_collectionName).add(activity.toFirestore());
  }

  Future<void> updateActivity(Activity activity) async {
    if (activity.id == null) {
      throw Exception("Activity ID cannot be null for update");
    }
    await _db.collection(_collectionName).doc(activity.id).update(activity.toFirestore());
  }

  Future<void> deleteActivity(String activityId) async {
    await _db.collection(_collectionName).doc(activityId).delete();
  }

  Future<void> markActivityAsCompleted(String activityId) async {
    await _db.collection(_collectionName).doc(activityId).update({
      'status': 'Selesai',
      'timestamp_updated': Timestamp.now(),
    });
  }
}
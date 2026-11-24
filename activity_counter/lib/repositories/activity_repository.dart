import '../data/activity_data.dart';
import '../models/activity_model.dart';

class ActivityRepository {
  final ActivityData _activityData;

  ActivityRepository(this._activityData);

  // Mengambil seluruh data aktivitas
  List<ActivityModel> getAllActivities() {
    return _activityData.activities;
  }

  // Mengambil 1 data aktivitas berdasarkan ID
  ActivityModel? getActivityById(String id) {
    try {
      return _activityData.activities.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  // Menambahkan aktivitas baru
  void addActivity(ActivityModel activity) {
    _activityData.activities.add(activity);
  }

  // Mengubah nama aktivitas
  void updateActivityName(String id, String newName) {
    final index = _activityData.activities.indexWhere((item) => item.id == id);
    if (index != -1) {
      _activityData.activities[index].name = newName;
    }
  }

  // Menghapus aktivitas
  void deleteActivity(String id) {
    _activityData.activities.removeWhere((item) => item.id == id);
  }

  // Memperbarui nilai counter
  void updateCounter(String id, int newCounter) {
    final index = _activityData.activities.indexWhere((item) => item.id == id);
    if (index != -1) {
      _activityData.activities[index].counter = newCounter;
    }
  }
}
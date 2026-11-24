import 'package:flutter/foundation.dart';
import '../models/activity_model.dart';
import '../repositories/activity_repository.dart';

class ActivityViewModel extends ChangeNotifier {
  final ActivityRepository _repository;

  ActivityViewModel(this._repository);

  // Mengambil daftar aktivitas dari Repository
  List<ActivityModel> get activities => _repository.getAllActivities();

  // Mengambil detail aktivitas berdasarkan ID
  ActivityModel? getActivityById(String id) {
    return _repository.getActivityById(id);
  }

  // Menambahkan aktivitas baru
  void addActivity(String name) {
    final newActivity = ActivityModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
      counter: 0,
    );
    _repository.addActivity(newActivity);
    notifyListeners(); // Memberitahu View untuk memperbarui tampilan
  }

  // Mengubah nama aktivitas
  void updateActivityName(String id, String newName) {
    _repository.updateActivityName(id, newName.trim());
    notifyListeners();
  }

  // Menghapus aktivitas
  void deleteActivity(String id) {
    _repository.deleteActivity(id);
    notifyListeners();
  }

  // Menambah counter (+1)
  void incrementCounter(String id) {
    final activity = _repository.getActivityById(id);
    if (activity != null) {
      _repository.updateCounter(id, activity.counter + 1);
      notifyListeners();
    }
  }

  // Mengurangi counter (-1), tidak boleh kurang dari 0
  bool decrementCounter(String id) {
    final activity = _repository.getActivityById(id);
    if (activity != null && activity.counter > 0) {
      _repository.updateCounter(id, activity.counter - 1);
      notifyListeners();
      return true;
    }
    return false;
  }

  // Mengembalikan counter menjadi 0
  void resetCounter(String id) {
    _repository.updateCounter(id, 0);
    notifyListeners();
  }
}
import '../models/activity_model.dart';

class ActivityData {
  // Penyimpanan data sementara selama aplikasi berjalan
  final List<ActivityModel> activities = [
    ActivityModel(id: '1', name: 'Membaca Buku', counter: 2),
    ActivityModel(id: '2', name: 'Olahraga / Push Up', counter: 10),
    ActivityModel(id: '3', name: 'Mengerjakan Tugas Kuliah', counter: 1),
  ];
}
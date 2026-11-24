import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/activity_data.dart';
import 'repositories/activity_repository.dart';
import 'viewmodels/activity_viewmodel.dart';
import 'views/home_view.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  final activityData = ActivityData();
  final activityRepository = ActivityRepository(activityData);
  final activityViewModel = ActivityViewModel(activityRepository);

  runApp(MyApp(viewModel: activityViewModel));
}

class MyApp extends StatelessWidget {
  final ActivityViewModel viewModel;

  const MyApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF472B6), // Pink Pastel utama
          primary: const Color(0xFFEC4899),
          secondary: const Color(0xFFF9A8D4),
          surface: const Color(0xFFFFF8FA),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF5F7), // Blush lembut
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFBCFE8),
          foregroundColor: Color(0xFF831843),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: HomeView(viewModel: viewModel),
    );
  }
}

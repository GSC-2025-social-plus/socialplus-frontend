import 'package:flutter/material.dart';
import 'package:social_plus_fe/presentation/pages/home_screen.dart';
import 'package:social_plus_fe/presentation/pages/lesson_selection_screen.dart';
import 'package:social_plus_fe/presentation/viewmodels/lesson_select_viewmodel.dart';
import 'presentation/pages/type_choose_screen.dart';
import 'presentation/pages/job_type_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LessonSelectViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LessonSelectScreen(),
    );
  }
}

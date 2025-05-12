import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';
import 'package:social_plus_fe/presentation/widgets/app_scaffold.dart';
import '../viewmodels/home_viewmodel.dart';
import '../viewmodels/user_preferences_viewmodel.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/lesson_card.dart';
import '../widgets/primary_action_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final viewModel = context.read<HomeViewModel>();
      viewModel.loadLessons();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final prefsViewModel = context.read<UserPreferencesViewModel>();
    final selectedType = prefsViewModel.conversationType;

    return CommonScaffold(
      title: "김민성님",
      selectedNavIndex: 0,
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이번주 인기강좌 TOP 5',
              style: AppTextStyles.subtitleR.copyWith(color: AppColors.text),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 330,
              child: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                clipBehavior: Clip.none,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.lessons.length,
                padding: const EdgeInsets.only(right: 16),
                itemBuilder: (context, index) {
                  final lesson = viewModel.lessons[index];
                  return LessonCard(
                    imagePath: lesson.imagePath,
                    title: lesson.title,
                    description: lesson.description,
                    buttonText: lesson.isAvailable ? '시작하기' : '레슨 완료 후 이용하세요',
                    onPressed: lesson.isAvailable
                        ? () {}
                        : null,
                  );
                },
              ),
            ),
            const SizedBox(height: 76),
            Text(
              '맞춤 대화 연습을 진행해보세요',
              style: AppTextStyles.subtitleR.copyWith(color: AppColors.text),
            ),
            const SizedBox(height: 12),
            PrimaryActionButton(
              text: '레슨 진행하기',
              onPressed: () {
                if (selectedType != null && selectedType.isNotEmpty) {
                  context.push('/lesson-selection'); // 대화 유형 선택 O
                } else {
                  context.push('/type-choose'); // 대화 유형 선택 X
                }
              },
              icon: Image.asset(
                'assets/images/leftArrowCircle.png',
                width: 24,
                height: 24,
              ),
              alignment: MainAxisAlignment.start,
              width: 280,
            ),
          ],
        ),
      ),
    );
  }
}
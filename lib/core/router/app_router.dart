import 'package:go_router/go_router.dart';
import 'package:jp_study_app/features/home/presentation/pages/home_page.dart';
import 'package:jp_study_app/features/kana/presentation/pages/kana_list_page.dart';
import 'package:jp_study_app/features/exam/presentation/pages/exam_page.dart';
import 'package:jp_study_app/features/exam/presentation/pages/exam_result_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/kana', builder: (context, state) => const KanaListPage()),
    GoRoute(path: '/exam', builder: (context, state) => const ExamPage()),
    GoRoute(
      path: '/exam_result',
      builder: (context, state) => const ExamResultPage(),
    ),
  ],
);

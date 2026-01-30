import 'package:go_router/go_router.dart';
import 'package:jp_study_app/features/kana/presentation/pages/kana_list_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const KanaListPage()),
  ],
);

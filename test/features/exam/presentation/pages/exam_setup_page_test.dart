import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jp_study_app/features/exam/presentation/pages/exam_setup_page.dart';
import 'package:jp_study_app/core/theme/theme.dart';

void main() {
  testWidgets('ExamSetupPage 應正確渲染標題與設定區塊', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(theme: AppTheme.light, home: const ExamSetupPage()),
      ),
    );

    expect(find.text('準備驗收'), findsOneWidget);
    expect(find.text('しけん設定'), findsOneWidget);
    expect(find.text('假名類型'), findsOneWidget);
    expect(find.text('範圍選擇'), findsOneWidget);
    expect(find.text('驗收模式'), findsOneWidget);
    expect(find.text('開始驗收'), findsOneWidget);
  });
}

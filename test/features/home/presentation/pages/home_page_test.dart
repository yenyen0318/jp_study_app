import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jp_study_app/features/home/presentation/pages/home_page.dart';
import 'package:jp_study_app/core/theme/theme.dart';

void main() {
  testWidgets('HomePage 應渲染所有導航選項', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(theme: AppTheme.light, home: const HomePage()),
      ),
    );

    expect(find.text('五十音'), findsOneWidget);
    expect(find.text('單字'), findsOneWidget);
    expect(find.text('測驗'), findsOneWidget);
    expect(find.text('かな'), findsOneWidget);
    expect(find.text('ことば'), findsOneWidget);
    expect(find.text('しけん'), findsOneWidget);
  });
}

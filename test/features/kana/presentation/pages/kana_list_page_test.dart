import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/features/kana/presentation/pages/kana_list_page.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_view_model.dart';
import 'package:mocktail/mocktail.dart';

// Mock ViewModel is harder with Riverpod Generator unless we override the repository in the container.
// We will override the repository provider to return a mock repository.

import 'package:jp_study_app/features/kana/domain/repositories/kana_repository.dart';

class MockKanaRepository extends Mock implements KanaRepository {}

void main() {
  late MockKanaRepository mockRepository;

  setUp(() {
    mockRepository = MockKanaRepository();
  });

  testWidgets('KanaListPage displays kana grid', (WidgetTester tester) async {
    // Arrange
    final mockData = [
      const Kana(
        id: '1',
        text: 'あ',
        romaji: 'a',
        type: 'hiragana',
        row: 0,
        col: 0,
      ),
      const Kana(
        id: '2',
        text: 'い',
        romaji: 'i',
        type: 'hiragana',
        row: 0,
        col: 1,
      ),
    ];
    when(() => mockRepository.getHiragana()).thenAnswer((_) async => mockData);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [kanaRepositoryProvider.overrideWithValue(mockRepository)],
        child: MaterialApp(theme: AppTheme.light, home: const KanaListPage()),
      ),
    );

    // Act
    // Initial state might be loading
    expect(find.text('準備中...'), findsOneWidget);

    await tester.pump(); // Trigger future builder
    await tester.pump(
      const Duration(milliseconds: 10),
    ); // Wait for animation/delay

    // Assert
    expect(find.text('五十音'), findsOneWidget);
    expect(find.text('あ'), findsOneWidget);
    expect(find.text('い'), findsOneWidget);
    expect(find.text('a'), findsOneWidget);
  });
}

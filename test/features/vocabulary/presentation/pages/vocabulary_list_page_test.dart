import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/vocabulary/domain/entities/vocabulary.dart';
import 'package:jp_study_app/features/vocabulary/presentation/pages/vocabulary_list_page.dart';
import 'package:jp_study_app/features/vocabulary/presentation/providers/vocabulary_provider.dart';
import 'package:jp_study_app/features/vocabulary/data/repositories/vocabulary_repository.dart';
import 'package:jp_study_app/features/vocabulary/presentation/widgets/vocabulary_card.dart';
import 'package:mocktail/mocktail.dart';

class MockVocabularyRepository extends Mock implements VocabularyRepository {}

void main() {
  late MockVocabularyRepository mockRepository;

  setUp(() {
    mockRepository = MockVocabularyRepository();
  });

  testWidgets('VocabularyListPage displays vocabulary list', (
    WidgetTester tester,
  ) async {
    // 準備 (Arrange)
    final mockData = [
      const Vocabulary(
        id: '1',
        text: '日本語',
        furigana: 'にほんご',
        romaji: 'nihongo',
        segments: [
          VocabSegment(text: '日本', reading: 'にほん'),
          VocabSegment(text: '語', reading: 'ご'),
        ],
        meaning: '日文',
        tags: ['名詞'],
      ),
    ];

    when(
      () => mockRepository.getN5Vocabularies(),
    ).thenAnswer((_) async => mockData);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          vocabularyRepositoryProvider.overrideWithValue(mockRepository),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const VocabularyListPage(),
        ),
      ),
    );

    // 等待加載完成與動畫結束
    await tester.pump(); // 觸發 build
    await tester.pump(const Duration(milliseconds: 100)); // 開始非同步任務
    await tester.pumpAndSettle(); // 等待所有動畫與任務結束

    // 驗證 (Assert)
    expect(find.text('N5 單字學習'), findsOneWidget);

    // 驗證是否有渲染 VocabularyCard
    expect(find.byType(VocabularyCard), findsOneWidget);

    // 驗證中文意思 (這個通常不會被 RubyText 分割)
    expect(find.text('日文'), findsOneWidget);

    // 驗證日文文本片段 (因為 RubyText 會分割)
    expect(find.textContaining('日本'), findsOneWidget);
    expect(find.textContaining('語'), findsOneWidget);
  });
}

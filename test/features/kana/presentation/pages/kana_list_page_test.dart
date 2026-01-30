import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/features/kana/presentation/pages/kana_list_page.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_view_model.dart';
import 'package:mocktail/mocktail.dart';

// 模擬 ViewModel 在使用 Riverpod Generator 時較困難，除非我們在容器中覆蓋 repository
// 我們將覆蓋 repository provider 以回傳模擬的 repository

import 'package:jp_study_app/features/kana/domain/repositories/kana_repository.dart';

class MockKanaRepository extends Mock implements KanaRepository {}

void main() {
  late MockKanaRepository mockRepository;

  setUp(() {
    mockRepository = MockKanaRepository();
  });

  testWidgets('KanaListPage displays kana grid', (WidgetTester tester) async {
    // 準備 (Arrange)
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

    // 操作 (Act)
    // 初始狀態可能是載入中
    expect(find.text('準備中...'), findsOneWidget);

    await tester.pump(); // 觸發 future builder
    await tester.pump(const Duration(milliseconds: 10)); // 等待動畫/延遲

    // 驗證 (Assert)
    expect(find.text('五十音'), findsOneWidget);
    expect(find.text('あ'), findsOneWidget);
    expect(find.text('い'), findsOneWidget);
    expect(find.text('a'), findsOneWidget);
  });
}

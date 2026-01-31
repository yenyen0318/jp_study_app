import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/exam/domain/entities/quiz.dart';
import 'package:jp_study_app/features/exam/domain/repositories/exam_repository.dart';
import 'package:jp_study_app/features/exam/presentation/pages/exam_page.dart';
import 'package:jp_study_app/features/exam/presentation/providers/exam_controller.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/core/services/tts_service.dart';
import 'package:jp_study_app/features/exam/data/repositories/exam_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockExamRepository extends Mock implements ExamRepository {}

class MockTtsService extends Mock implements TtsService {}

void main() {
  late MockExamRepository mockRepository;
  late MockTtsService mockTtsService;

  setUp(() {
    mockRepository = MockExamRepository();
    mockTtsService = MockTtsService();
    registerFallbackValue(const ExamScope(types: ['hiragana'], rows: [0]));
    when(() => mockTtsService.speak(any())).thenAnswer((_) async {});
  });

  const kanaNu = Kana(
    id: 'nu',
    text: 'ぬ',
    romaji: 'nu',
    type: 'hiragana',
    row: 4,
    col: 2,
    mnemonic: 'ぬ 是有小圈圈的麵條',
  );

  testWidgets('答錯時應該顯示助記提示，答對或未答則不顯示', (WidgetTester tester) async {
    // 準備題目
    final questions = [
      ReadingQuestion(correctKana: kanaNu, options: ['nu', 'me', 'ne', 'a']),
    ];

    when(
      () => mockRepository.generateExam(
        scope: any(named: 'scope'),
        questionCount: any(named: 'questionCount'),
      ),
    ).thenAnswer((_) async => questions);

    final container = ProviderContainer(
      overrides: [
        examRepositoryProvider.overrideWithValue(mockRepository),
        ttsServiceProvider.overrideWithValue(mockTtsService),
      ],
    );

    // 設定大的螢幕尺寸以確保測試環境的一致性，避免溢出
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(theme: AppTheme.light, home: const ExamPage()),
      ),
    );

    // 1. 初始化考試
    await container
        .read(examControllerProvider.notifier)
        .startExam(const ExamScope(types: ['hiragana'], rows: [4]));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // 驗證初始狀態：不顯示提示
    expect(find.text('💡 記憶小撇步'), findsNothing);
    expect(find.text(kanaNu.mnemonic!), findsNothing);

    // 2. 選擇正確答案 'nu'
    await tester.tap(find.text('nu'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // 驗證答對狀態：不顯示提示
    expect(find.text('💡 記憶小撇步'), findsNothing);

    // 重置以便測試答錯
    await container
        .read(examControllerProvider.notifier)
        .startExam(const ExamScope(types: ['hiragana'], rows: [4]));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // 3. 選擇錯誤答案 'a'
    await tester.tap(find.text('a'));
    await tester.pump();
    // 答錯後會有動畫，我們等待足夠長的時間
    await tester.pump(const Duration(milliseconds: 1000));

    // 驗證答錯狀態：顯示提示
    expect(find.text('💡 記憶小撇步'), findsOneWidget);
    expect(find.text(kanaNu.mnemonic!), findsOneWidget);
  });
}

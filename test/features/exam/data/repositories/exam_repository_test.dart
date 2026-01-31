import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:jp_study_app/features/exam/domain/entities/quiz.dart';
import 'package:jp_study_app/features/exam/data/repositories/exam_repository_impl.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/features/kana/domain/repositories/kana_repository.dart';

class MockKanaRepository extends Mock implements KanaRepository {}

void main() {
  late MockKanaRepository mockKanaRepository;
  late ExamRepositoryImpl examRepository;

  setUp(() {
    mockKanaRepository = MockKanaRepository();
    examRepository = ExamRepositoryImpl(mockKanaRepository);
  });

  group('ExamRepositoryImpl', () {
    final kanaNu = const Kana(
      id: 'nu',
      text: 'ぬ',
      romaji: 'nu',
      type: 'hiragana',
      row: 4,
      col: 2,
      similarKanaIds: ['me', 'ne'],
    );
    final kanaMe = const Kana(
      id: 'me',
      text: 'め',
      romaji: 'me',
      type: 'hiragana',
      row: 7,
      col: 3,
    );
    final kanaNe = const Kana(
      id: 'ne',
      text: 'ne',
      romaji: 'ne',
      type: 'hiragana',
      row: 4,
      col: 3,
    );
    final kanaA = const Kana(
      id: 'a',
      text: 'あ',
      romaji: 'a',
      type: 'hiragana',
      row: 0,
      col: 0,
    );

    test('應該只從驗收範圍內選擇干擾項', () async {
      // Arrange
      final allHiragana = [kanaNu, kanaMe, kanaNe, kanaA];
      when(
        () => mockKanaRepository.getHiragana(),
      ).thenAnswer((_) async => allHiragana);
      when(() => mockKanaRepository.getKatakana()).thenAnswer((_) async => []);

      // 使用隨機抽樣模式確保只生成 1 題
      final scope = ExamScope(
        types: ['hiragana'],
        rows: [4], // な行 (包含 ぬ, ね)
        isRandomSampling: true,
      );

      // Act
      final questions = await examRepository.generateExam(
        scope: scope,
        questionCount: 1,
      );

      // Assert
      expect(questions.length, 1);
      final question = questions.first;

      // 驗證所有選項都來自驗收範圍（な行）
      // な行只有 nu 和 ne，所以選項應該只包含這兩個
      if (question is ReadingQuestion) {
        for (final option in question.options) {
          expect(['nu', 'ne'], contains(option));
        }
      } else if (question is ListeningQuestion) {
        for (final option in question.options) {
          expect(['ぬ', 'ne'], contains(option));
        }
      }
    });

    test('若驗收範圍內假名不足，選項數量會相應減少', () async {
      // Arrange
      final uniqueKana = const Kana(
        id: 'unique',
        text: 'x',
        romaji: 'x',
        type: 'hiragana',
        row: 0,
        col: 0,
      );
      final other1 = const Kana(
        id: 'o1',
        text: 'o1',
        romaji: 'o1',
        type: 'hiragana',
        row: 1,
        col: 1,
      );
      final other2 = const Kana(
        id: 'o2',
        text: 'o2',
        romaji: 'o2',
        type: 'hiragana',
        row: 1,
        col: 2,
      );
      final other3 = const Kana(
        id: 'o3',
        text: 'o3',
        romaji: 'o3',
        type: 'hiragana',
        row: 1,
        col: 3,
      );

      final allHiragana = [uniqueKana, other1, other2, other3];
      when(
        () => mockKanaRepository.getHiragana(),
      ).thenAnswer((_) async => allHiragana);
      when(() => mockKanaRepository.getKatakana()).thenAnswer((_) async => []);

      final scope = ExamScope(types: ['hiragana'], rows: [0]);

      // Act
      final questions = await examRepository.generateExam(
        scope: scope,
        questionCount: 1,
      );

      // Assert
      // 驗收範圍內只有 uniqueKana，所以選項只有 1 個（正確答案）
      expect(questions.first.options.length, 1);
    });
  });
}

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

    test('應該優先選擇相似字作為干擾項', () async {
      // Arrange
      final allHiragana = [kanaNu, kanaMe, kanaNe, kanaA];
      when(
        () => mockKanaRepository.getHiragana(),
      ).thenAnswer((_) async => allHiragana);
      when(() => mockKanaRepository.getKatakana()).thenAnswer((_) async => []);

      final scope = ExamScope(types: ['hiragana'], rows: [4]); // な行 (包含 ぬ, ね)

      // Act
      final questions = await examRepository.generateExam(
        scope: scope,
        questionCount: 1,
      );

      // Assert
      expect(questions.length, 1);
      final question = questions.first;

      // 不管抽到的是 nu 還是 ne，只要它有相似字，選項中就應該包含那些相似字
      final correctKana = question.correctKana;
      if (correctKana.id == 'nu') {
        if (question is ReadingQuestion) {
          expect(question.options, contains('me'));
          expect(question.options, contains('ne'));
        }
      } else if (correctKana.id == 'ne') {
        // ne 沒有設定相似字，所以這裡不特定檢查相似字
        expect(question.options.length, 4);
      }
    });

    test('若相似字不足，應從同類型假名中補足', () async {
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
      expect(questions.first.options.length, 4); // 1 正確 + 3 錯誤
    });
  });
}

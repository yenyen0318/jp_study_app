import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:jp_study_app/features/exam/domain/entities/quiz.dart';
import 'package:jp_study_app/features/exam/domain/repositories/exam_repository.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/features/kana/domain/repositories/kana_repository.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_view_model.dart';

part 'exam_repository_impl.g.dart';

class ExamRepositoryImpl implements ExamRepository {
  final KanaRepository _kanaRepository;
  final Random _random = Random();

  ExamRepositoryImpl(this._kanaRepository);

  @override
  Future<List<QuizQuestion>> generateExam({
    required ExamScope scope,
    int questionCount = 10,
  }) async {
    final List<Kana> allPossibleKana = [];

    // 獲取所有符合類型的 Kana
    if (scope.types.contains('hiragana')) {
      allPossibleKana.addAll(await _kanaRepository.getHiragana());
    }
    if (scope.types.contains('katakana')) {
      allPossibleKana.addAll(await _kanaRepository.getKatakana());
    }

    // 根據行 (row) 過濾
    final filteredKana = allPossibleKana
        .where((k) => scope.rows.contains(k.row))
        .toList();

    if (filteredKana.isEmpty) return [];

    // 打亂順序並取出指定數量的題目
    filteredKana.shuffle(_random);
    final selectedKana = filteredKana.take(questionCount).toList();

    return selectedKana.map((kana) {
      // 隨機決定題型：50% 閱讀, 50% 聽力
      final isListening = _random.nextBool();

      // 生成選項 (1 正確 + 3 錯誤)
      // 錯誤選項應該盡量是同類型的
      final sameTypeKana = allPossibleKana
          .where((k) => k.type == kana.type && k.id != kana.id)
          .toList();
      sameTypeKana.shuffle(_random);
      final distractors = sameTypeKana.take(3).toList();

      if (isListening) {
        final options = [kana.text, ...distractors.map((d) => d.text)];
        options.shuffle(_random);
        return ListeningQuestion(correctKana: kana, options: options);
      } else {
        final options = [kana.romaji, ...distractors.map((d) => d.romaji)];
        options.shuffle(_random);
        return ReadingQuestion(correctKana: kana, options: options);
      }
    }).toList();
  }
}

@riverpod
ExamRepository examRepository(Ref ref) {
  return ExamRepositoryImpl(ref.watch(kanaRepositoryProvider));
}

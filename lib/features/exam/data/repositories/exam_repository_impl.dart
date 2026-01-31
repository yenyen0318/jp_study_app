import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:jp_study_app/features/exam/domain/entities/quiz.dart';
import 'package:jp_study_app/features/exam/domain/repositories/exam_repository.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana_type.dart';
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

    // 獲獲所有符合類型的 Kana
    if (scope.types.contains(KanaType.hiragana)) {
      allPossibleKana.addAll(await _kanaRepository.getHiragana());
    }
    if (scope.types.contains(KanaType.katakana)) {
      allPossibleKana.addAll(await _kanaRepository.getKatakana());
    }

    // 根據行 (row) 過濾，同時排除重複音
    final filteredKana = allPossibleKana
        .where((k) => scope.rows.contains(k.row) && !k.isDuplicate)
        .toList();

    if (filteredKana.isEmpty) return [];

    // 根據模式決定題目數量
    final int actualQuestionCount;
    if (scope.isRandomSampling) {
      // 隨機抽樣模式：固定 10 題（或範圍內假名數量，取較小值）
      actualQuestionCount = questionCount < filteredKana.length
          ? questionCount
          : filteredKana.length;
    } else {
      // 完整覆蓋模式：確保每個假名都出現，至少 5 題
      actualQuestionCount = filteredKana.length < 5 ? 5 : filteredKana.length;
    }

    // 打亂順序並取出指定數量的題目
    filteredKana.shuffle(_random);
    final selectedKana = filteredKana.take(actualQuestionCount).toList();

    return selectedKana.map((kana) {
      // 隨機決定題型：50% 閱讀, 50% 聽力
      final isListening = _random.nextBool();

      // 生成選項 (1 正確 + 3 錯誤)
      // 錯誤選項只從驗收範圍內選擇（修正問題 2）
      final sameTypeKana = filteredKana
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

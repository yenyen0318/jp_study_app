import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';

part 'quiz.freezed.dart';

/// 考試題目的基本類型
sealed class QuizQuestion {
  final Kana correctKana;
  final List<String> options;

  QuizQuestion({required this.correctKana, required this.options});
}

/// 閱讀測驗：顯示字元，選羅馬拼音
class ReadingQuestion extends QuizQuestion {
  ReadingQuestion({required super.correctKana, required super.options});
}

/// 聽力測驗：聽聲音，選字元
class ListeningQuestion extends QuizQuestion {
  ListeningQuestion({required super.correctKana, required super.options});
}

/// 記錄錯誤的答題資訊
@freezed
class WrongAnswer with _$WrongAnswer {
  const factory WrongAnswer({
    required QuizQuestion question,
    required String selectedOption,
  }) = _WrongAnswer;
}

/// 考試最終結果
@freezed
class ExamResult with _$ExamResult {
  const factory ExamResult({
    required List<QuizQuestion> questions,
    required List<WrongAnswer> wrongAnswers,
    required double score,
    required int totalQuestions,
    required String feedbackQuote,
    required String hankoLabel, // 印章文字，如 '完', '良', '精進'
  }) = _ExamResult;
}

/// 考試範圍設定
@freezed
class ExamScope with _$ExamScope {
  const factory ExamScope({
    required List<String> types, // ['hiragana', 'katakana']
    required List<int> rows, // [0, 1, 2...] 代表 あ行, か行...
  }) = _ExamScope;
}

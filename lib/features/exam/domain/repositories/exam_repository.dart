import 'package:jp_study_app/features/exam/domain/entities/quiz.dart';

/// 負責考試資料取得與邏輯生成的 Repository
abstract class ExamRepository {
  /// 根據範圍設定生成隨機測驗題目
  Future<List<QuizQuestion>> generateExam({
    required ExamScope scope,
    int questionCount = 10,
  });
}

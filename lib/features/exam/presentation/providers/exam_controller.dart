import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:jp_study_app/features/exam/data/repositories/exam_repository_impl.dart';
import 'package:jp_study_app/features/exam/domain/entities/quiz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_controller.freezed.dart';
part 'exam_controller.g.dart';

@freezed
class ExamState with _$ExamState {
  const factory ExamState({
    @Default([]) List<QuizQuestion> questions,
    @Default(0) int currentIndex,
    @Default([]) List<WrongAnswer> wrongAnswers,
    @Default(true) bool isAnswered,
    @Default(null) String? selectedOption,
    @Default(false) bool isCorrect,
    @Default(null) ExamResult? result,
    @Default(null) ExamScope? scope,
  }) = _ExamState;

  const ExamState._();

  bool get isFinished =>
      questions.isNotEmpty && currentIndex >= questions.length;
}

@Riverpod(keepAlive: true)
class ExamController extends _$ExamController {
  @override
  FutureOr<ExamState> build() {
    return const ExamState();
  }

  /// 開始一場新的考試
  Future<void> startExam(ExamScope scope) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(examRepositoryProvider);
      final questions = await repository.generateExam(scope: scope);
      return ExamState(
        questions: questions,
        currentIndex: 0,
        isAnswered: false,
        scope: scope,
      );
    });
  }

  /// 以相同範圍重新開始
  Future<void> retry() async {
    final currentScope = state.value?.scope;
    if (currentScope != null) {
      await startExam(currentScope);
    }
  }

  /// 答題
  void answer(String option) {
    final currentState = state.value;
    if (currentState == null || currentState.isAnswered) return;

    final currentQuestion = currentState.questions[currentState.currentIndex];
    final bool isCorrect = _checkAnswer(currentQuestion, option);

    final List<WrongAnswer> newWrongAnswers = List.from(
      currentState.wrongAnswers,
    );
    if (!isCorrect) {
      newWrongAnswers.add(
        WrongAnswer(question: currentQuestion, selectedOption: option),
      );
    }

    state = AsyncValue.data(
      currentState.copyWith(
        isAnswered: true,
        selectedOption: option,
        isCorrect: isCorrect,
        wrongAnswers: newWrongAnswers,
      ),
    );
  }

  /// 進入下一題
  void nextQuestion() {
    final currentState = state.value;
    if (currentState == null || !currentState.isAnswered) return;

    if (currentState.currentIndex < currentState.questions.length - 1) {
      state = AsyncValue.data(
        currentState.copyWith(
          currentIndex: currentState.currentIndex + 1,
          isAnswered: false,
          selectedOption: null,
        ),
      );
    } else {
      // 結束考試，生成結果
      _finishExam();
    }
  }

  void _finishExam() {
    final currentState = state.value;
    if (currentState == null) return;

    final score =
        (currentState.questions.length - currentState.wrongAnswers.length) /
        currentState.questions.length;

    String feedback;
    String hanko;

    if (score >= 1.0) {
      feedback = '心如明鏡，無一絲瑕疵。';
      hanko = '完';
    } else if (score >= 0.8) {
      feedback = '一步一腳印，花開終有時。';
      hanko = '良';
    } else {
      feedback = '日日是好日，今日亦有所獲。';
      hanko = '精進';
    }

    final result = ExamResult(
      questions: currentState.questions,
      wrongAnswers: currentState.wrongAnswers,
      score: score,
      totalQuestions: currentState.questions.length,
      feedbackQuote: feedback,
      hankoLabel: hanko,
    );

    state = AsyncValue.data(currentState.copyWith(result: result));
  }

  bool _checkAnswer(QuizQuestion question, String option) {
    if (question is ReadingQuestion) {
      return question.correctKana.romaji == option;
    } else if (question is ListeningQuestion) {
      return question.correctKana.text == option;
    }
    return false;
  }

  /// 重新開始
  void reset() {
    state = const AsyncValue.data(ExamState());
  }
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WrongAnswer {
  QuizQuestion get question => throw _privateConstructorUsedError;
  String get selectedOption => throw _privateConstructorUsedError;

  /// Create a copy of WrongAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WrongAnswerCopyWith<WrongAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WrongAnswerCopyWith<$Res> {
  factory $WrongAnswerCopyWith(
    WrongAnswer value,
    $Res Function(WrongAnswer) then,
  ) = _$WrongAnswerCopyWithImpl<$Res, WrongAnswer>;
  @useResult
  $Res call({QuizQuestion question, String selectedOption});
}

/// @nodoc
class _$WrongAnswerCopyWithImpl<$Res, $Val extends WrongAnswer>
    implements $WrongAnswerCopyWith<$Res> {
  _$WrongAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WrongAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? question = null, Object? selectedOption = null}) {
    return _then(
      _value.copyWith(
            question: null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as QuizQuestion,
            selectedOption: null == selectedOption
                ? _value.selectedOption
                : selectedOption // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WrongAnswerImplCopyWith<$Res>
    implements $WrongAnswerCopyWith<$Res> {
  factory _$$WrongAnswerImplCopyWith(
    _$WrongAnswerImpl value,
    $Res Function(_$WrongAnswerImpl) then,
  ) = __$$WrongAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({QuizQuestion question, String selectedOption});
}

/// @nodoc
class __$$WrongAnswerImplCopyWithImpl<$Res>
    extends _$WrongAnswerCopyWithImpl<$Res, _$WrongAnswerImpl>
    implements _$$WrongAnswerImplCopyWith<$Res> {
  __$$WrongAnswerImplCopyWithImpl(
    _$WrongAnswerImpl _value,
    $Res Function(_$WrongAnswerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WrongAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? question = null, Object? selectedOption = null}) {
    return _then(
      _$WrongAnswerImpl(
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as QuizQuestion,
        selectedOption: null == selectedOption
            ? _value.selectedOption
            : selectedOption // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$WrongAnswerImpl implements _WrongAnswer {
  const _$WrongAnswerImpl({
    required this.question,
    required this.selectedOption,
  });

  @override
  final QuizQuestion question;
  @override
  final String selectedOption;

  @override
  String toString() {
    return 'WrongAnswer(question: $question, selectedOption: $selectedOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WrongAnswerImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.selectedOption, selectedOption) ||
                other.selectedOption == selectedOption));
  }

  @override
  int get hashCode => Object.hash(runtimeType, question, selectedOption);

  /// Create a copy of WrongAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WrongAnswerImplCopyWith<_$WrongAnswerImpl> get copyWith =>
      __$$WrongAnswerImplCopyWithImpl<_$WrongAnswerImpl>(this, _$identity);
}

abstract class _WrongAnswer implements WrongAnswer {
  const factory _WrongAnswer({
    required final QuizQuestion question,
    required final String selectedOption,
  }) = _$WrongAnswerImpl;

  @override
  QuizQuestion get question;
  @override
  String get selectedOption;

  /// Create a copy of WrongAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WrongAnswerImplCopyWith<_$WrongAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExamResult {
  List<QuizQuestion> get questions => throw _privateConstructorUsedError;
  List<WrongAnswer> get wrongAnswers => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  int get totalQuestions => throw _privateConstructorUsedError;
  String get feedbackQuote => throw _privateConstructorUsedError;
  String get hankoLabel => throw _privateConstructorUsedError;

  /// Create a copy of ExamResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExamResultCopyWith<ExamResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExamResultCopyWith<$Res> {
  factory $ExamResultCopyWith(
    ExamResult value,
    $Res Function(ExamResult) then,
  ) = _$ExamResultCopyWithImpl<$Res, ExamResult>;
  @useResult
  $Res call({
    List<QuizQuestion> questions,
    List<WrongAnswer> wrongAnswers,
    double score,
    int totalQuestions,
    String feedbackQuote,
    String hankoLabel,
  });
}

/// @nodoc
class _$ExamResultCopyWithImpl<$Res, $Val extends ExamResult>
    implements $ExamResultCopyWith<$Res> {
  _$ExamResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExamResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questions = null,
    Object? wrongAnswers = null,
    Object? score = null,
    Object? totalQuestions = null,
    Object? feedbackQuote = null,
    Object? hankoLabel = null,
  }) {
    return _then(
      _value.copyWith(
            questions: null == questions
                ? _value.questions
                : questions // ignore: cast_nullable_to_non_nullable
                      as List<QuizQuestion>,
            wrongAnswers: null == wrongAnswers
                ? _value.wrongAnswers
                : wrongAnswers // ignore: cast_nullable_to_non_nullable
                      as List<WrongAnswer>,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as double,
            totalQuestions: null == totalQuestions
                ? _value.totalQuestions
                : totalQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            feedbackQuote: null == feedbackQuote
                ? _value.feedbackQuote
                : feedbackQuote // ignore: cast_nullable_to_non_nullable
                      as String,
            hankoLabel: null == hankoLabel
                ? _value.hankoLabel
                : hankoLabel // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExamResultImplCopyWith<$Res>
    implements $ExamResultCopyWith<$Res> {
  factory _$$ExamResultImplCopyWith(
    _$ExamResultImpl value,
    $Res Function(_$ExamResultImpl) then,
  ) = __$$ExamResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<QuizQuestion> questions,
    List<WrongAnswer> wrongAnswers,
    double score,
    int totalQuestions,
    String feedbackQuote,
    String hankoLabel,
  });
}

/// @nodoc
class __$$ExamResultImplCopyWithImpl<$Res>
    extends _$ExamResultCopyWithImpl<$Res, _$ExamResultImpl>
    implements _$$ExamResultImplCopyWith<$Res> {
  __$$ExamResultImplCopyWithImpl(
    _$ExamResultImpl _value,
    $Res Function(_$ExamResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExamResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questions = null,
    Object? wrongAnswers = null,
    Object? score = null,
    Object? totalQuestions = null,
    Object? feedbackQuote = null,
    Object? hankoLabel = null,
  }) {
    return _then(
      _$ExamResultImpl(
        questions: null == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<QuizQuestion>,
        wrongAnswers: null == wrongAnswers
            ? _value._wrongAnswers
            : wrongAnswers // ignore: cast_nullable_to_non_nullable
                  as List<WrongAnswer>,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as double,
        totalQuestions: null == totalQuestions
            ? _value.totalQuestions
            : totalQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        feedbackQuote: null == feedbackQuote
            ? _value.feedbackQuote
            : feedbackQuote // ignore: cast_nullable_to_non_nullable
                  as String,
        hankoLabel: null == hankoLabel
            ? _value.hankoLabel
            : hankoLabel // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ExamResultImpl implements _ExamResult {
  const _$ExamResultImpl({
    required final List<QuizQuestion> questions,
    required final List<WrongAnswer> wrongAnswers,
    required this.score,
    required this.totalQuestions,
    required this.feedbackQuote,
    required this.hankoLabel,
  }) : _questions = questions,
       _wrongAnswers = wrongAnswers;

  final List<QuizQuestion> _questions;
  @override
  List<QuizQuestion> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  final List<WrongAnswer> _wrongAnswers;
  @override
  List<WrongAnswer> get wrongAnswers {
    if (_wrongAnswers is EqualUnmodifiableListView) return _wrongAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wrongAnswers);
  }

  @override
  final double score;
  @override
  final int totalQuestions;
  @override
  final String feedbackQuote;
  @override
  final String hankoLabel;

  @override
  String toString() {
    return 'ExamResult(questions: $questions, wrongAnswers: $wrongAnswers, score: $score, totalQuestions: $totalQuestions, feedbackQuote: $feedbackQuote, hankoLabel: $hankoLabel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExamResultImpl &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ) &&
            const DeepCollectionEquality().equals(
              other._wrongAnswers,
              _wrongAnswers,
            ) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.feedbackQuote, feedbackQuote) ||
                other.feedbackQuote == feedbackQuote) &&
            (identical(other.hankoLabel, hankoLabel) ||
                other.hankoLabel == hankoLabel));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_questions),
    const DeepCollectionEquality().hash(_wrongAnswers),
    score,
    totalQuestions,
    feedbackQuote,
    hankoLabel,
  );

  /// Create a copy of ExamResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExamResultImplCopyWith<_$ExamResultImpl> get copyWith =>
      __$$ExamResultImplCopyWithImpl<_$ExamResultImpl>(this, _$identity);
}

abstract class _ExamResult implements ExamResult {
  const factory _ExamResult({
    required final List<QuizQuestion> questions,
    required final List<WrongAnswer> wrongAnswers,
    required final double score,
    required final int totalQuestions,
    required final String feedbackQuote,
    required final String hankoLabel,
  }) = _$ExamResultImpl;

  @override
  List<QuizQuestion> get questions;
  @override
  List<WrongAnswer> get wrongAnswers;
  @override
  double get score;
  @override
  int get totalQuestions;
  @override
  String get feedbackQuote;
  @override
  String get hankoLabel;

  /// Create a copy of ExamResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExamResultImplCopyWith<_$ExamResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExamScope {
  List<String> get types =>
      throw _privateConstructorUsedError; // ['hiragana', 'katakana']
  List<int> get rows => throw _privateConstructorUsedError;

  /// Create a copy of ExamScope
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExamScopeCopyWith<ExamScope> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExamScopeCopyWith<$Res> {
  factory $ExamScopeCopyWith(ExamScope value, $Res Function(ExamScope) then) =
      _$ExamScopeCopyWithImpl<$Res, ExamScope>;
  @useResult
  $Res call({List<String> types, List<int> rows});
}

/// @nodoc
class _$ExamScopeCopyWithImpl<$Res, $Val extends ExamScope>
    implements $ExamScopeCopyWith<$Res> {
  _$ExamScopeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExamScope
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? types = null, Object? rows = null}) {
    return _then(
      _value.copyWith(
            types: null == types
                ? _value.types
                : types // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            rows: null == rows
                ? _value.rows
                : rows // ignore: cast_nullable_to_non_nullable
                      as List<int>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExamScopeImplCopyWith<$Res>
    implements $ExamScopeCopyWith<$Res> {
  factory _$$ExamScopeImplCopyWith(
    _$ExamScopeImpl value,
    $Res Function(_$ExamScopeImpl) then,
  ) = __$$ExamScopeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> types, List<int> rows});
}

/// @nodoc
class __$$ExamScopeImplCopyWithImpl<$Res>
    extends _$ExamScopeCopyWithImpl<$Res, _$ExamScopeImpl>
    implements _$$ExamScopeImplCopyWith<$Res> {
  __$$ExamScopeImplCopyWithImpl(
    _$ExamScopeImpl _value,
    $Res Function(_$ExamScopeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExamScope
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? types = null, Object? rows = null}) {
    return _then(
      _$ExamScopeImpl(
        types: null == types
            ? _value._types
            : types // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        rows: null == rows
            ? _value._rows
            : rows // ignore: cast_nullable_to_non_nullable
                  as List<int>,
      ),
    );
  }
}

/// @nodoc

class _$ExamScopeImpl implements _ExamScope {
  const _$ExamScopeImpl({
    required final List<String> types,
    required final List<int> rows,
  }) : _types = types,
       _rows = rows;

  final List<String> _types;
  @override
  List<String> get types {
    if (_types is EqualUnmodifiableListView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_types);
  }

  // ['hiragana', 'katakana']
  final List<int> _rows;
  // ['hiragana', 'katakana']
  @override
  List<int> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  String toString() {
    return 'ExamScope(types: $types, rows: $rows)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExamScopeImpl &&
            const DeepCollectionEquality().equals(other._types, _types) &&
            const DeepCollectionEquality().equals(other._rows, _rows));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_types),
    const DeepCollectionEquality().hash(_rows),
  );

  /// Create a copy of ExamScope
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExamScopeImplCopyWith<_$ExamScopeImpl> get copyWith =>
      __$$ExamScopeImplCopyWithImpl<_$ExamScopeImpl>(this, _$identity);
}

abstract class _ExamScope implements ExamScope {
  const factory _ExamScope({
    required final List<String> types,
    required final List<int> rows,
  }) = _$ExamScopeImpl;

  @override
  List<String> get types; // ['hiragana', 'katakana']
  @override
  List<int> get rows;

  /// Create a copy of ExamScope
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExamScopeImplCopyWith<_$ExamScopeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ExamState {
  List<QuizQuestion> get questions => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  List<WrongAnswer> get wrongAnswers => throw _privateConstructorUsedError;
  bool get isAnswered => throw _privateConstructorUsedError;
  String? get selectedOption => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  ExamResult? get result => throw _privateConstructorUsedError;
  ExamScope? get scope => throw _privateConstructorUsedError;

  /// Create a copy of ExamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExamStateCopyWith<ExamState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExamStateCopyWith<$Res> {
  factory $ExamStateCopyWith(ExamState value, $Res Function(ExamState) then) =
      _$ExamStateCopyWithImpl<$Res, ExamState>;
  @useResult
  $Res call({
    List<QuizQuestion> questions,
    int currentIndex,
    List<WrongAnswer> wrongAnswers,
    bool isAnswered,
    String? selectedOption,
    bool isCorrect,
    ExamResult? result,
    ExamScope? scope,
  });

  $ExamResultCopyWith<$Res>? get result;
  $ExamScopeCopyWith<$Res>? get scope;
}

/// @nodoc
class _$ExamStateCopyWithImpl<$Res, $Val extends ExamState>
    implements $ExamStateCopyWith<$Res> {
  _$ExamStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questions = null,
    Object? currentIndex = null,
    Object? wrongAnswers = null,
    Object? isAnswered = null,
    Object? selectedOption = freezed,
    Object? isCorrect = null,
    Object? result = freezed,
    Object? scope = freezed,
  }) {
    return _then(
      _value.copyWith(
            questions: null == questions
                ? _value.questions
                : questions // ignore: cast_nullable_to_non_nullable
                      as List<QuizQuestion>,
            currentIndex: null == currentIndex
                ? _value.currentIndex
                : currentIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            wrongAnswers: null == wrongAnswers
                ? _value.wrongAnswers
                : wrongAnswers // ignore: cast_nullable_to_non_nullable
                      as List<WrongAnswer>,
            isAnswered: null == isAnswered
                ? _value.isAnswered
                : isAnswered // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedOption: freezed == selectedOption
                ? _value.selectedOption
                : selectedOption // ignore: cast_nullable_to_non_nullable
                      as String?,
            isCorrect: null == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool,
            result: freezed == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                      as ExamResult?,
            scope: freezed == scope
                ? _value.scope
                : scope // ignore: cast_nullable_to_non_nullable
                      as ExamScope?,
          )
          as $Val,
    );
  }

  /// Create a copy of ExamState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExamResultCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $ExamResultCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }

  /// Create a copy of ExamState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExamScopeCopyWith<$Res>? get scope {
    if (_value.scope == null) {
      return null;
    }

    return $ExamScopeCopyWith<$Res>(_value.scope!, (value) {
      return _then(_value.copyWith(scope: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExamStateImplCopyWith<$Res>
    implements $ExamStateCopyWith<$Res> {
  factory _$$ExamStateImplCopyWith(
    _$ExamStateImpl value,
    $Res Function(_$ExamStateImpl) then,
  ) = __$$ExamStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<QuizQuestion> questions,
    int currentIndex,
    List<WrongAnswer> wrongAnswers,
    bool isAnswered,
    String? selectedOption,
    bool isCorrect,
    ExamResult? result,
    ExamScope? scope,
  });

  @override
  $ExamResultCopyWith<$Res>? get result;
  @override
  $ExamScopeCopyWith<$Res>? get scope;
}

/// @nodoc
class __$$ExamStateImplCopyWithImpl<$Res>
    extends _$ExamStateCopyWithImpl<$Res, _$ExamStateImpl>
    implements _$$ExamStateImplCopyWith<$Res> {
  __$$ExamStateImplCopyWithImpl(
    _$ExamStateImpl _value,
    $Res Function(_$ExamStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questions = null,
    Object? currentIndex = null,
    Object? wrongAnswers = null,
    Object? isAnswered = null,
    Object? selectedOption = freezed,
    Object? isCorrect = null,
    Object? result = freezed,
    Object? scope = freezed,
  }) {
    return _then(
      _$ExamStateImpl(
        questions: null == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<QuizQuestion>,
        currentIndex: null == currentIndex
            ? _value.currentIndex
            : currentIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        wrongAnswers: null == wrongAnswers
            ? _value._wrongAnswers
            : wrongAnswers // ignore: cast_nullable_to_non_nullable
                  as List<WrongAnswer>,
        isAnswered: null == isAnswered
            ? _value.isAnswered
            : isAnswered // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedOption: freezed == selectedOption
            ? _value.selectedOption
            : selectedOption // ignore: cast_nullable_to_non_nullable
                  as String?,
        isCorrect: null == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool,
        result: freezed == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as ExamResult?,
        scope: freezed == scope
            ? _value.scope
            : scope // ignore: cast_nullable_to_non_nullable
                  as ExamScope?,
      ),
    );
  }
}

/// @nodoc

class _$ExamStateImpl extends _ExamState {
  const _$ExamStateImpl({
    final List<QuizQuestion> questions = const [],
    this.currentIndex = 0,
    final List<WrongAnswer> wrongAnswers = const [],
    this.isAnswered = true,
    this.selectedOption = null,
    this.isCorrect = false,
    this.result = null,
    this.scope = null,
  }) : _questions = questions,
       _wrongAnswers = wrongAnswers,
       super._();

  final List<QuizQuestion> _questions;
  @override
  @JsonKey()
  List<QuizQuestion> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  @JsonKey()
  final int currentIndex;
  final List<WrongAnswer> _wrongAnswers;
  @override
  @JsonKey()
  List<WrongAnswer> get wrongAnswers {
    if (_wrongAnswers is EqualUnmodifiableListView) return _wrongAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wrongAnswers);
  }

  @override
  @JsonKey()
  final bool isAnswered;
  @override
  @JsonKey()
  final String? selectedOption;
  @override
  @JsonKey()
  final bool isCorrect;
  @override
  @JsonKey()
  final ExamResult? result;
  @override
  @JsonKey()
  final ExamScope? scope;

  @override
  String toString() {
    return 'ExamState(questions: $questions, currentIndex: $currentIndex, wrongAnswers: $wrongAnswers, isAnswered: $isAnswered, selectedOption: $selectedOption, isCorrect: $isCorrect, result: $result, scope: $scope)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExamStateImpl &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            const DeepCollectionEquality().equals(
              other._wrongAnswers,
              _wrongAnswers,
            ) &&
            (identical(other.isAnswered, isAnswered) ||
                other.isAnswered == isAnswered) &&
            (identical(other.selectedOption, selectedOption) ||
                other.selectedOption == selectedOption) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.scope, scope) || other.scope == scope));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_questions),
    currentIndex,
    const DeepCollectionEquality().hash(_wrongAnswers),
    isAnswered,
    selectedOption,
    isCorrect,
    result,
    scope,
  );

  /// Create a copy of ExamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExamStateImplCopyWith<_$ExamStateImpl> get copyWith =>
      __$$ExamStateImplCopyWithImpl<_$ExamStateImpl>(this, _$identity);
}

abstract class _ExamState extends ExamState {
  const factory _ExamState({
    final List<QuizQuestion> questions,
    final int currentIndex,
    final List<WrongAnswer> wrongAnswers,
    final bool isAnswered,
    final String? selectedOption,
    final bool isCorrect,
    final ExamResult? result,
    final ExamScope? scope,
  }) = _$ExamStateImpl;
  const _ExamState._() : super._();

  @override
  List<QuizQuestion> get questions;
  @override
  int get currentIndex;
  @override
  List<WrongAnswer> get wrongAnswers;
  @override
  bool get isAnswered;
  @override
  String? get selectedOption;
  @override
  bool get isCorrect;
  @override
  ExamResult? get result;
  @override
  ExamScope? get scope;

  /// Create a copy of ExamState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExamStateImplCopyWith<_$ExamStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'writing_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WritingState {
  List<List<Offset>> get currentStrokes => throw _privateConstructorUsedError;
  bool get isFading => throw _privateConstructorUsedError;

  /// Create a copy of WritingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WritingStateCopyWith<WritingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WritingStateCopyWith<$Res> {
  factory $WritingStateCopyWith(
    WritingState value,
    $Res Function(WritingState) then,
  ) = _$WritingStateCopyWithImpl<$Res, WritingState>;
  @useResult
  $Res call({List<List<Offset>> currentStrokes, bool isFading});
}

/// @nodoc
class _$WritingStateCopyWithImpl<$Res, $Val extends WritingState>
    implements $WritingStateCopyWith<$Res> {
  _$WritingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WritingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? currentStrokes = null, Object? isFading = null}) {
    return _then(
      _value.copyWith(
            currentStrokes: null == currentStrokes
                ? _value.currentStrokes
                : currentStrokes // ignore: cast_nullable_to_non_nullable
                      as List<List<Offset>>,
            isFading: null == isFading
                ? _value.isFading
                : isFading // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WritingStateImplCopyWith<$Res>
    implements $WritingStateCopyWith<$Res> {
  factory _$$WritingStateImplCopyWith(
    _$WritingStateImpl value,
    $Res Function(_$WritingStateImpl) then,
  ) = __$$WritingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<List<Offset>> currentStrokes, bool isFading});
}

/// @nodoc
class __$$WritingStateImplCopyWithImpl<$Res>
    extends _$WritingStateCopyWithImpl<$Res, _$WritingStateImpl>
    implements _$$WritingStateImplCopyWith<$Res> {
  __$$WritingStateImplCopyWithImpl(
    _$WritingStateImpl _value,
    $Res Function(_$WritingStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WritingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? currentStrokes = null, Object? isFading = null}) {
    return _then(
      _$WritingStateImpl(
        currentStrokes: null == currentStrokes
            ? _value._currentStrokes
            : currentStrokes // ignore: cast_nullable_to_non_nullable
                  as List<List<Offset>>,
        isFading: null == isFading
            ? _value.isFading
            : isFading // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$WritingStateImpl implements _WritingState {
  const _$WritingStateImpl({
    final List<List<Offset>> currentStrokes = const [],
    this.isFading = false,
  }) : _currentStrokes = currentStrokes;

  final List<List<Offset>> _currentStrokes;
  @override
  @JsonKey()
  List<List<Offset>> get currentStrokes {
    if (_currentStrokes is EqualUnmodifiableListView) return _currentStrokes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentStrokes);
  }

  @override
  @JsonKey()
  final bool isFading;

  @override
  String toString() {
    return 'WritingState(currentStrokes: $currentStrokes, isFading: $isFading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WritingStateImpl &&
            const DeepCollectionEquality().equals(
              other._currentStrokes,
              _currentStrokes,
            ) &&
            (identical(other.isFading, isFading) ||
                other.isFading == isFading));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_currentStrokes),
    isFading,
  );

  /// Create a copy of WritingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WritingStateImplCopyWith<_$WritingStateImpl> get copyWith =>
      __$$WritingStateImplCopyWithImpl<_$WritingStateImpl>(this, _$identity);
}

abstract class _WritingState implements WritingState {
  const factory _WritingState({
    final List<List<Offset>> currentStrokes,
    final bool isFading,
  }) = _$WritingStateImpl;

  @override
  List<List<Offset>> get currentStrokes;
  @override
  bool get isFading;

  /// Create a copy of WritingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WritingStateImplCopyWith<_$WritingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

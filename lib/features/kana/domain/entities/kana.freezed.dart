// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kana.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Kana _$KanaFromJson(Map<String, dynamic> json) {
  return _Kana.fromJson(json);
}

/// @nodoc
mixin _$Kana {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get romaji => throw _privateConstructorUsedError;
  KanaType get type => throw _privateConstructorUsedError;
  int get row => throw _privateConstructorUsedError;
  int get col => throw _privateConstructorUsedError;
  bool get isDuplicate => throw _privateConstructorUsedError;
  String? get mnemonic => throw _privateConstructorUsedError;
  List<String> get similarKanaIds => throw _privateConstructorUsedError;
  List<List<List<double>>> get strokes => throw _privateConstructorUsedError;

  /// Serializes this Kana to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Kana
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KanaCopyWith<Kana> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KanaCopyWith<$Res> {
  factory $KanaCopyWith(Kana value, $Res Function(Kana) then) =
      _$KanaCopyWithImpl<$Res, Kana>;
  @useResult
  $Res call({
    String id,
    String text,
    String romaji,
    KanaType type,
    int row,
    int col,
    bool isDuplicate,
    String? mnemonic,
    List<String> similarKanaIds,
    List<List<List<double>>> strokes,
  });
}

/// @nodoc
class _$KanaCopyWithImpl<$Res, $Val extends Kana>
    implements $KanaCopyWith<$Res> {
  _$KanaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Kana
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? romaji = null,
    Object? type = null,
    Object? row = null,
    Object? col = null,
    Object? isDuplicate = null,
    Object? mnemonic = freezed,
    Object? similarKanaIds = null,
    Object? strokes = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            romaji: null == romaji
                ? _value.romaji
                : romaji // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as KanaType,
            row: null == row
                ? _value.row
                : row // ignore: cast_nullable_to_non_nullable
                      as int,
            col: null == col
                ? _value.col
                : col // ignore: cast_nullable_to_non_nullable
                      as int,
            isDuplicate: null == isDuplicate
                ? _value.isDuplicate
                : isDuplicate // ignore: cast_nullable_to_non_nullable
                      as bool,
            mnemonic: freezed == mnemonic
                ? _value.mnemonic
                : mnemonic // ignore: cast_nullable_to_non_nullable
                      as String?,
            similarKanaIds: null == similarKanaIds
                ? _value.similarKanaIds
                : similarKanaIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            strokes: null == strokes
                ? _value.strokes
                : strokes // ignore: cast_nullable_to_non_nullable
                      as List<List<List<double>>>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KanaImplCopyWith<$Res> implements $KanaCopyWith<$Res> {
  factory _$$KanaImplCopyWith(
    _$KanaImpl value,
    $Res Function(_$KanaImpl) then,
  ) = __$$KanaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String text,
    String romaji,
    KanaType type,
    int row,
    int col,
    bool isDuplicate,
    String? mnemonic,
    List<String> similarKanaIds,
    List<List<List<double>>> strokes,
  });
}

/// @nodoc
class __$$KanaImplCopyWithImpl<$Res>
    extends _$KanaCopyWithImpl<$Res, _$KanaImpl>
    implements _$$KanaImplCopyWith<$Res> {
  __$$KanaImplCopyWithImpl(_$KanaImpl _value, $Res Function(_$KanaImpl) _then)
    : super(_value, _then);

  /// Create a copy of Kana
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? romaji = null,
    Object? type = null,
    Object? row = null,
    Object? col = null,
    Object? isDuplicate = null,
    Object? mnemonic = freezed,
    Object? similarKanaIds = null,
    Object? strokes = null,
  }) {
    return _then(
      _$KanaImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        romaji: null == romaji
            ? _value.romaji
            : romaji // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as KanaType,
        row: null == row
            ? _value.row
            : row // ignore: cast_nullable_to_non_nullable
                  as int,
        col: null == col
            ? _value.col
            : col // ignore: cast_nullable_to_non_nullable
                  as int,
        isDuplicate: null == isDuplicate
            ? _value.isDuplicate
            : isDuplicate // ignore: cast_nullable_to_non_nullable
                  as bool,
        mnemonic: freezed == mnemonic
            ? _value.mnemonic
            : mnemonic // ignore: cast_nullable_to_non_nullable
                  as String?,
        similarKanaIds: null == similarKanaIds
            ? _value._similarKanaIds
            : similarKanaIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        strokes: null == strokes
            ? _value._strokes
            : strokes // ignore: cast_nullable_to_non_nullable
                  as List<List<List<double>>>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$KanaImpl implements _Kana {
  const _$KanaImpl({
    required this.id,
    required this.text,
    required this.romaji,
    required this.type,
    required this.row,
    required this.col,
    this.isDuplicate = false,
    this.mnemonic,
    final List<String> similarKanaIds = const [],
    final List<List<List<double>>> strokes = const [],
  }) : _similarKanaIds = similarKanaIds,
       _strokes = strokes;

  factory _$KanaImpl.fromJson(Map<String, dynamic> json) =>
      _$$KanaImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  final String romaji;
  @override
  final KanaType type;
  @override
  final int row;
  @override
  final int col;
  @override
  @JsonKey()
  final bool isDuplicate;
  @override
  final String? mnemonic;
  final List<String> _similarKanaIds;
  @override
  @JsonKey()
  List<String> get similarKanaIds {
    if (_similarKanaIds is EqualUnmodifiableListView) return _similarKanaIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_similarKanaIds);
  }

  final List<List<List<double>>> _strokes;
  @override
  @JsonKey()
  List<List<List<double>>> get strokes {
    if (_strokes is EqualUnmodifiableListView) return _strokes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_strokes);
  }

  @override
  String toString() {
    return 'Kana(id: $id, text: $text, romaji: $romaji, type: $type, row: $row, col: $col, isDuplicate: $isDuplicate, mnemonic: $mnemonic, similarKanaIds: $similarKanaIds, strokes: $strokes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KanaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.romaji, romaji) || other.romaji == romaji) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.row, row) || other.row == row) &&
            (identical(other.col, col) || other.col == col) &&
            (identical(other.isDuplicate, isDuplicate) ||
                other.isDuplicate == isDuplicate) &&
            (identical(other.mnemonic, mnemonic) ||
                other.mnemonic == mnemonic) &&
            const DeepCollectionEquality().equals(
              other._similarKanaIds,
              _similarKanaIds,
            ) &&
            const DeepCollectionEquality().equals(other._strokes, _strokes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    text,
    romaji,
    type,
    row,
    col,
    isDuplicate,
    mnemonic,
    const DeepCollectionEquality().hash(_similarKanaIds),
    const DeepCollectionEquality().hash(_strokes),
  );

  /// Create a copy of Kana
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KanaImplCopyWith<_$KanaImpl> get copyWith =>
      __$$KanaImplCopyWithImpl<_$KanaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KanaImplToJson(this);
  }
}

abstract class _Kana implements Kana {
  const factory _Kana({
    required final String id,
    required final String text,
    required final String romaji,
    required final KanaType type,
    required final int row,
    required final int col,
    final bool isDuplicate,
    final String? mnemonic,
    final List<String> similarKanaIds,
    final List<List<List<double>>> strokes,
  }) = _$KanaImpl;

  factory _Kana.fromJson(Map<String, dynamic> json) = _$KanaImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  String get romaji;
  @override
  KanaType get type;
  @override
  int get row;
  @override
  int get col;
  @override
  bool get isDuplicate;
  @override
  String? get mnemonic;
  @override
  List<String> get similarKanaIds;
  @override
  List<List<List<double>>> get strokes;

  /// Create a copy of Kana
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KanaImplCopyWith<_$KanaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

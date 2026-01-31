// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vocabulary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Vocabulary _$VocabularyFromJson(Map<String, dynamic> json) {
  return _Vocabulary.fromJson(json);
}

/// @nodoc
mixin _$Vocabulary {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError; // 完整原文，例如：日本語
  String get furigana => throw _privateConstructorUsedError; // 純平假名，供搜尋與排序：にほんご
  String get romaji => throw _privateConstructorUsedError; // 羅馬拼音：nihongo
  List<VocabSegment> get segments =>
      throw _privateConstructorUsedError; // 分詞結構，供振假名標註
  String get meaning => throw _privateConstructorUsedError; // 繁體中文解釋
  List<String> get tags =>
      throw _privateConstructorUsedError; // 標籤，如 'N5', '名詞', '動詞'
  int get masteryLevel => throw _privateConstructorUsedError; // 掌握度 (0-5)
  DateTime? get lastReviewed => throw _privateConstructorUsedError;

  /// Serializes this Vocabulary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Vocabulary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VocabularyCopyWith<Vocabulary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VocabularyCopyWith<$Res> {
  factory $VocabularyCopyWith(
    Vocabulary value,
    $Res Function(Vocabulary) then,
  ) = _$VocabularyCopyWithImpl<$Res, Vocabulary>;
  @useResult
  $Res call({
    String id,
    String text,
    String furigana,
    String romaji,
    List<VocabSegment> segments,
    String meaning,
    List<String> tags,
    int masteryLevel,
    DateTime? lastReviewed,
  });
}

/// @nodoc
class _$VocabularyCopyWithImpl<$Res, $Val extends Vocabulary>
    implements $VocabularyCopyWith<$Res> {
  _$VocabularyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Vocabulary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? furigana = null,
    Object? romaji = null,
    Object? segments = null,
    Object? meaning = null,
    Object? tags = null,
    Object? masteryLevel = null,
    Object? lastReviewed = freezed,
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
            furigana: null == furigana
                ? _value.furigana
                : furigana // ignore: cast_nullable_to_non_nullable
                      as String,
            romaji: null == romaji
                ? _value.romaji
                : romaji // ignore: cast_nullable_to_non_nullable
                      as String,
            segments: null == segments
                ? _value.segments
                : segments // ignore: cast_nullable_to_non_nullable
                      as List<VocabSegment>,
            meaning: null == meaning
                ? _value.meaning
                : meaning // ignore: cast_nullable_to_non_nullable
                      as String,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            masteryLevel: null == masteryLevel
                ? _value.masteryLevel
                : masteryLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            lastReviewed: freezed == lastReviewed
                ? _value.lastReviewed
                : lastReviewed // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VocabularyImplCopyWith<$Res>
    implements $VocabularyCopyWith<$Res> {
  factory _$$VocabularyImplCopyWith(
    _$VocabularyImpl value,
    $Res Function(_$VocabularyImpl) then,
  ) = __$$VocabularyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String text,
    String furigana,
    String romaji,
    List<VocabSegment> segments,
    String meaning,
    List<String> tags,
    int masteryLevel,
    DateTime? lastReviewed,
  });
}

/// @nodoc
class __$$VocabularyImplCopyWithImpl<$Res>
    extends _$VocabularyCopyWithImpl<$Res, _$VocabularyImpl>
    implements _$$VocabularyImplCopyWith<$Res> {
  __$$VocabularyImplCopyWithImpl(
    _$VocabularyImpl _value,
    $Res Function(_$VocabularyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Vocabulary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? furigana = null,
    Object? romaji = null,
    Object? segments = null,
    Object? meaning = null,
    Object? tags = null,
    Object? masteryLevel = null,
    Object? lastReviewed = freezed,
  }) {
    return _then(
      _$VocabularyImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        furigana: null == furigana
            ? _value.furigana
            : furigana // ignore: cast_nullable_to_non_nullable
                  as String,
        romaji: null == romaji
            ? _value.romaji
            : romaji // ignore: cast_nullable_to_non_nullable
                  as String,
        segments: null == segments
            ? _value._segments
            : segments // ignore: cast_nullable_to_non_nullable
                  as List<VocabSegment>,
        meaning: null == meaning
            ? _value.meaning
            : meaning // ignore: cast_nullable_to_non_nullable
                  as String,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        masteryLevel: null == masteryLevel
            ? _value.masteryLevel
            : masteryLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        lastReviewed: freezed == lastReviewed
            ? _value.lastReviewed
            : lastReviewed // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VocabularyImpl implements _Vocabulary {
  const _$VocabularyImpl({
    required this.id,
    required this.text,
    required this.furigana,
    required this.romaji,
    required final List<VocabSegment> segments,
    required this.meaning,
    final List<String> tags = const [],
    this.masteryLevel = 0,
    this.lastReviewed,
  }) : _segments = segments,
       _tags = tags;

  factory _$VocabularyImpl.fromJson(Map<String, dynamic> json) =>
      _$$VocabularyImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  // 完整原文，例如：日本語
  @override
  final String furigana;
  // 純平假名，供搜尋與排序：にほんご
  @override
  final String romaji;
  // 羅馬拼音：nihongo
  final List<VocabSegment> _segments;
  // 羅馬拼音：nihongo
  @override
  List<VocabSegment> get segments {
    if (_segments is EqualUnmodifiableListView) return _segments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_segments);
  }

  // 分詞結構，供振假名標註
  @override
  final String meaning;
  // 繁體中文解釋
  final List<String> _tags;
  // 繁體中文解釋
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  // 標籤，如 'N5', '名詞', '動詞'
  @override
  @JsonKey()
  final int masteryLevel;
  // 掌握度 (0-5)
  @override
  final DateTime? lastReviewed;

  @override
  String toString() {
    return 'Vocabulary(id: $id, text: $text, furigana: $furigana, romaji: $romaji, segments: $segments, meaning: $meaning, tags: $tags, masteryLevel: $masteryLevel, lastReviewed: $lastReviewed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VocabularyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.furigana, furigana) ||
                other.furigana == furigana) &&
            (identical(other.romaji, romaji) || other.romaji == romaji) &&
            const DeepCollectionEquality().equals(other._segments, _segments) &&
            (identical(other.meaning, meaning) || other.meaning == meaning) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.masteryLevel, masteryLevel) ||
                other.masteryLevel == masteryLevel) &&
            (identical(other.lastReviewed, lastReviewed) ||
                other.lastReviewed == lastReviewed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    text,
    furigana,
    romaji,
    const DeepCollectionEquality().hash(_segments),
    meaning,
    const DeepCollectionEquality().hash(_tags),
    masteryLevel,
    lastReviewed,
  );

  /// Create a copy of Vocabulary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VocabularyImplCopyWith<_$VocabularyImpl> get copyWith =>
      __$$VocabularyImplCopyWithImpl<_$VocabularyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VocabularyImplToJson(this);
  }
}

abstract class _Vocabulary implements Vocabulary {
  const factory _Vocabulary({
    required final String id,
    required final String text,
    required final String furigana,
    required final String romaji,
    required final List<VocabSegment> segments,
    required final String meaning,
    final List<String> tags,
    final int masteryLevel,
    final DateTime? lastReviewed,
  }) = _$VocabularyImpl;

  factory _Vocabulary.fromJson(Map<String, dynamic> json) =
      _$VocabularyImpl.fromJson;

  @override
  String get id;
  @override
  String get text; // 完整原文，例如：日本語
  @override
  String get furigana; // 純平假名，供搜尋與排序：にほんご
  @override
  String get romaji; // 羅馬拼音：nihongo
  @override
  List<VocabSegment> get segments; // 分詞結構，供振假名標註
  @override
  String get meaning; // 繁體中文解釋
  @override
  List<String> get tags; // 標籤，如 'N5', '名詞', '動詞'
  @override
  int get masteryLevel; // 掌握度 (0-5)
  @override
  DateTime? get lastReviewed;

  /// Create a copy of Vocabulary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VocabularyImplCopyWith<_$VocabularyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VocabSegment _$VocabSegmentFromJson(Map<String, dynamic> json) {
  return _VocabSegment.fromJson(json);
}

/// @nodoc
mixin _$VocabSegment {
  String get text => throw _privateConstructorUsedError; // 漢字或假名片段
  String? get reading => throw _privateConstructorUsedError;

  /// Serializes this VocabSegment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VocabSegment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VocabSegmentCopyWith<VocabSegment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VocabSegmentCopyWith<$Res> {
  factory $VocabSegmentCopyWith(
    VocabSegment value,
    $Res Function(VocabSegment) then,
  ) = _$VocabSegmentCopyWithImpl<$Res, VocabSegment>;
  @useResult
  $Res call({String text, String? reading});
}

/// @nodoc
class _$VocabSegmentCopyWithImpl<$Res, $Val extends VocabSegment>
    implements $VocabSegmentCopyWith<$Res> {
  _$VocabSegmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VocabSegment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = null, Object? reading = freezed}) {
    return _then(
      _value.copyWith(
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            reading: freezed == reading
                ? _value.reading
                : reading // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VocabSegmentImplCopyWith<$Res>
    implements $VocabSegmentCopyWith<$Res> {
  factory _$$VocabSegmentImplCopyWith(
    _$VocabSegmentImpl value,
    $Res Function(_$VocabSegmentImpl) then,
  ) = __$$VocabSegmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String? reading});
}

/// @nodoc
class __$$VocabSegmentImplCopyWithImpl<$Res>
    extends _$VocabSegmentCopyWithImpl<$Res, _$VocabSegmentImpl>
    implements _$$VocabSegmentImplCopyWith<$Res> {
  __$$VocabSegmentImplCopyWithImpl(
    _$VocabSegmentImpl _value,
    $Res Function(_$VocabSegmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VocabSegment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = null, Object? reading = freezed}) {
    return _then(
      _$VocabSegmentImpl(
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        reading: freezed == reading
            ? _value.reading
            : reading // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VocabSegmentImpl implements _VocabSegment {
  const _$VocabSegmentImpl({required this.text, this.reading});

  factory _$VocabSegmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$VocabSegmentImplFromJson(json);

  @override
  final String text;
  // 漢字或假名片段
  @override
  final String? reading;

  @override
  String toString() {
    return 'VocabSegment(text: $text, reading: $reading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VocabSegmentImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.reading, reading) || other.reading == reading));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, reading);

  /// Create a copy of VocabSegment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VocabSegmentImplCopyWith<_$VocabSegmentImpl> get copyWith =>
      __$$VocabSegmentImplCopyWithImpl<_$VocabSegmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VocabSegmentImplToJson(this);
  }
}

abstract class _VocabSegment implements VocabSegment {
  const factory _VocabSegment({
    required final String text,
    final String? reading,
  }) = _$VocabSegmentImpl;

  factory _VocabSegment.fromJson(Map<String, dynamic> json) =
      _$VocabSegmentImpl.fromJson;

  @override
  String get text; // 漢字或假名片段
  @override
  String? get reading;

  /// Create a copy of VocabSegment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VocabSegmentImplCopyWith<_$VocabSegmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

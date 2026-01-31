import 'package:freezed_annotation/freezed_annotation.dart';

part 'vocabulary.freezed.dart';
part 'vocabulary.g.dart';

@freezed
class Vocabulary with _$Vocabulary {
  const factory Vocabulary({
    required String id,
    required String text, // 完整原文，例如：日本語
    required String furigana, // 純平假名，供搜尋與排序：にほんご
    required String romaji, // 羅馬拼音：nihongo
    required List<VocabSegment> segments, // 分詞結構，供振假名標註
    required String meaning, // 繁體中文解釋
    @Default([]) List<String> tags, // 標籤，如 'N5', '名詞', '動詞'
    @Default(0) int masteryLevel, // 掌握度 (0-5)
    DateTime? lastReviewed, // 上次複習時間
  }) = _Vocabulary;

  factory Vocabulary.fromJson(Map<String, dynamic> json) =>
      _$VocabularyFromJson(json);
}

@freezed
class VocabSegment with _$VocabSegment {
  const factory VocabSegment({
    required String text, // 漢字或假名片段
    String? reading, // 對應的振假名 (若是假名片段則為 null)
  }) = _VocabSegment;

  factory VocabSegment.fromJson(Map<String, dynamic> json) =>
      _$VocabSegmentFromJson(json);
}

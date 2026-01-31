// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VocabularyImpl _$$VocabularyImplFromJson(Map<String, dynamic> json) =>
    _$VocabularyImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      furigana: json['furigana'] as String,
      romaji: json['romaji'] as String,
      segments: (json['segments'] as List<dynamic>)
          .map((e) => VocabSegment.fromJson(e as Map<String, dynamic>))
          .toList(),
      meaning: json['meaning'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      masteryLevel: (json['masteryLevel'] as num?)?.toInt() ?? 0,
      lastReviewed: json['lastReviewed'] == null
          ? null
          : DateTime.parse(json['lastReviewed'] as String),
    );

Map<String, dynamic> _$$VocabularyImplToJson(_$VocabularyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'furigana': instance.furigana,
      'romaji': instance.romaji,
      'segments': instance.segments,
      'meaning': instance.meaning,
      'tags': instance.tags,
      'masteryLevel': instance.masteryLevel,
      'lastReviewed': instance.lastReviewed?.toIso8601String(),
    };

_$VocabSegmentImpl _$$VocabSegmentImplFromJson(Map<String, dynamic> json) =>
    _$VocabSegmentImpl(
      text: json['text'] as String,
      reading: json['reading'] as String?,
    );

Map<String, dynamic> _$$VocabSegmentImplToJson(_$VocabSegmentImpl instance) =>
    <String, dynamic>{'text': instance.text, 'reading': instance.reading};

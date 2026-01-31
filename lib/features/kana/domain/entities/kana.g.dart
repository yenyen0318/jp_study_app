// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kana.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KanaImpl _$$KanaImplFromJson(Map<String, dynamic> json) => _$KanaImpl(
  id: json['id'] as String,
  text: json['text'] as String,
  romaji: json['romaji'] as String,
  type: json['type'] as String,
  row: (json['row'] as num).toInt(),
  col: (json['col'] as num).toInt(),
  isDuplicate: json['isDuplicate'] as bool? ?? false,
  mnemonic: json['mnemonic'] as String?,
  similarKanaIds:
      (json['similarKanaIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$KanaImplToJson(_$KanaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'romaji': instance.romaji,
      'type': instance.type,
      'row': instance.row,
      'col': instance.col,
      'isDuplicate': instance.isDuplicate,
      'mnemonic': instance.mnemonic,
      'similarKanaIds': instance.similarKanaIds,
    };

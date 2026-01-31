import 'package:freezed_annotation/freezed_annotation.dart';
import 'kana_type.dart';

part 'kana.freezed.dart';
part 'kana.g.dart';

@freezed
class Kana with _$Kana {
  const factory Kana({
    required String id,
    required String text,
    required String romaji,
    required KanaType type,
    required int row,
    required int col,
    @Default(false) bool isDuplicate,
    String? mnemonic,
    @Default([]) List<String> similarKanaIds,
    @Default([]) List<List<List<double>>> strokes,
  }) = _Kana;

  factory Kana.fromJson(Map<String, dynamic> json) => _$KanaFromJson(json);
}

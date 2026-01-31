import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kana_type_filter_provider.g.dart';

/// 假名類型枚舉
enum KanaType {
  hiragana('平假名'),
  katakana('片假名');

  final String label;
  const KanaType(this.label);
}

/// 假名類型篩選器
@riverpod
class KanaTypeFilter extends _$KanaTypeFilter {
  @override
  KanaType build() {
    return KanaType.hiragana;
  }

  /// 設定假名類型
  void setType(KanaType type) {
    state = type;
  }
}

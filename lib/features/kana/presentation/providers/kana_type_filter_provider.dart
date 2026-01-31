import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/kana_type.dart';

part 'kana_type_filter_provider.g.dart';

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

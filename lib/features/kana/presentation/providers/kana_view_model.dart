import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:jp_study_app/features/kana/data/repositories/kana_repository_impl.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana_type.dart';
import 'package:jp_study_app/features/kana/domain/repositories/kana_repository.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_type_filter_provider.dart';

part 'kana_view_model.g.dart';

@riverpod
KanaRepository kanaRepository(Ref ref) {
  return KanaRepositoryImpl();
}

@riverpod
class KanaListViewModel extends _$KanaListViewModel {
  @override
  Future<List<Kana>> build() async {
    final repository = ref.watch(kanaRepositoryProvider);
    final kanaType = ref.watch(kanaTypeFilterProvider);

    // 根據選擇的假名類型載入對應資料
    return kanaType == KanaType.hiragana
        ? repository.getHiragana()
        : repository.getKatakana();
  }
}

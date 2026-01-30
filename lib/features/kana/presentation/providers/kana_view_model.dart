import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:jp_study_app/features/kana/data/repositories/kana_repository_impl.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/features/kana/domain/repositories/kana_repository.dart';

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
    // 如果需要，可以在此模擬邏輯或直接獲取數據
    return repository.getHiragana();
  }
}

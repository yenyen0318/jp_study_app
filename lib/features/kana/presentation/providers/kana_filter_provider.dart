import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/kana_category.dart';

part 'kana_filter_provider.g.dart';

@riverpod
class KanaCategoryFilter extends _$KanaCategoryFilter {
  @override
  KanaCategory build() {
    return KanaCategory.all;
  }

  void setFilter(KanaCategory category) {
    state = category;
  }
}

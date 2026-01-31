import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kana_filter_provider.g.dart';

enum KanaCategory {
  all('全部'),
  seion('清音'),
  dakuon('濁音'),
  handakuon('半濁音'),
  youon('拗音');

  final String label;
  const KanaCategory(this.label);
}

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

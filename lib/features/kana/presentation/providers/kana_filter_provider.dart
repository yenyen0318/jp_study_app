import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kana_filter_provider.g.dart';

enum KanaCategory {
  all('全部', '所有的假名發音'),
  seion('清音', '最基礎的核心發音'),
  dakuon('濁音', '帶有「゛」，較渾厚的發音'),
  handakuon('半濁音', '帶有「゜」，較輕快的發音'),
  youon('拗音', '結合 y 音的組合音'),
  sokuon('促音', '停頓一拍的斷音'),
  choon('長音', '延伸一拍的長音'),
  modern('外來語', '現代外來語專用拼音');

  final String label;
  final String description;
  const KanaCategory(this.label, this.description);
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

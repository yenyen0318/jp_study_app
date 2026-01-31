import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/kana.dart';
import 'kana_filter_provider.dart';
import 'kana_view_model.dart';

part 'kana_groups_provider.g.dart';

class KanaGroup {
  final String title;
  final String? description;
  final List<Kana> items;
  final int crossAxisCount;

  KanaGroup({
    required this.title,
    this.description,
    required this.items,
    this.crossAxisCount = 5,
  });
}

@riverpod
FutureOr<List<KanaGroup>> filteredKanaGroups(Ref ref) async {
  final kanaListAsync = ref.watch(kanaListViewModelProvider);
  final selectedCategory = ref.watch(kanaCategoryFilterProvider);

  return kanaListAsync.when(
    data: (kanaList) {
      final groups = <KanaGroup>[];

      // Seion
      final seion = kanaList.where((k) => k.row >= 0 && k.row <= 9).toList();
      if (seion.isNotEmpty &&
          (selectedCategory == KanaCategory.all ||
              selectedCategory == KanaCategory.seion)) {
        groups.add(
          KanaGroup(
            title: '清音',
            description: KanaCategory.seion.description,
            items: seion,
          ),
        );
      }

      // Bion
      final bion = kanaList.where((k) => k.row == 10).toList();
      if (bion.isNotEmpty &&
          (selectedCategory == KanaCategory.all ||
              selectedCategory == KanaCategory.seion)) {
        groups.add(
          KanaGroup(title: '鼻音', description: '最後一個鼻音發音', items: bion),
        );
      }

      // Dakuon
      final dakuon = kanaList.where((k) => k.row >= 11 && k.row <= 14).toList();
      if (dakuon.isNotEmpty &&
          (selectedCategory == KanaCategory.all ||
              selectedCategory == KanaCategory.dakuon)) {
        groups.add(
          KanaGroup(
            title: '濁音',
            description: KanaCategory.dakuon.description,
            items: dakuon,
          ),
        );
      }

      // Handakuon
      final handakuon = kanaList.where((k) => k.row == 15).toList();
      if (handakuon.isNotEmpty &&
          (selectedCategory == KanaCategory.all ||
              selectedCategory == KanaCategory.handakuon)) {
        groups.add(
          KanaGroup(
            title: '半濁音',
            description: KanaCategory.handakuon.description,
            items: handakuon,
          ),
        );
      }

      // Youon
      final youon = kanaList.where((k) => k.row >= 16 && k.row <= 26).toList();
      if (youon.isNotEmpty &&
          (selectedCategory == KanaCategory.all ||
              selectedCategory == KanaCategory.youon)) {
        groups.add(
          KanaGroup(
            title: '拗音',
            description: KanaCategory.youon.description,
            items: youon,
            crossAxisCount: 3,
          ),
        );
      }

      // Sokuon
      final sokuon = kanaList
          .where((k) => k.row == 100 && k.id.contains('sokuon'))
          .toList();
      if (sokuon.isNotEmpty &&
          (selectedCategory == KanaCategory.all ||
              selectedCategory == KanaCategory.sokuon)) {
        groups.add(
          KanaGroup(
            title: '促音',
            description: KanaCategory.sokuon.description,
            items: sokuon,
            crossAxisCount: 3,
          ),
        );
      }

      // Choon
      final choon = kanaList.where((k) => k.row == 101).toList();
      if (choon.isNotEmpty &&
          (selectedCategory == KanaCategory.all ||
              selectedCategory == KanaCategory.choon)) {
        groups.add(
          KanaGroup(
            title: '長音',
            description: KanaCategory.choon.description,
            items: choon,
            crossAxisCount: 3,
          ),
        );
      }

      // Modern
      final modern = kanaList.where((k) => k.row >= 110).toList();
      if (modern.isNotEmpty &&
          (selectedCategory == KanaCategory.all ||
              selectedCategory == KanaCategory.modern)) {
        groups.add(
          KanaGroup(
            title: '外來語',
            description: KanaCategory.modern.description,
            items: modern,
            crossAxisCount: 3,
          ),
        );
      }

      return groups;
    },
    loading: () => [],
    error: (e, s) => [],
  );
}

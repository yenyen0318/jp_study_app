import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/vocabulary_repository.dart';
import '../../domain/entities/vocabulary.dart';

part 'vocabulary_provider.g.dart';

@riverpod
VocabularyRepository vocabularyRepository(Ref ref) {
  return VocabularyRepositoryImpl();
}

@riverpod
class VocabularySearchQuery extends _$VocabularySearchQuery {
  @override
  String build() => '';

  Timer? _debounceTimer;

  void setQuery(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      state = query;
    });
  }
}

@riverpod
class VocabularyFilter extends _$VocabularyFilter {
  @override
  String? build() => null;

  void setFilter(String? tag) {
    state = tag;
  }

  void updateFilters(String? tag) {
    state = tag;
  }

  void clearFilter() {
    state = null;
  }
}

/// 動態提取目前單字庫中除了 'N5' 以外的所有標籤
@riverpod
List<String> vocabularyAvailableTags(Ref ref) {
  final vocabsAsync = ref.watch(vocabularyNotifierProvider);
  return vocabsAsync.maybeWhen(
    data: (vocabs) {
      final tags = vocabs.expand((v) => v.tags).toSet();
      tags.remove('N5'); // N5 是基礎分類，不放在標籤過濾器中
      return tags.toList()..sort(); // 排序以穩定 UI 順序
    },
    orElse: () => [],
  );
}

@riverpod
class VocabularyNotifier extends _$VocabularyNotifier {
  @override
  FutureOr<List<Vocabulary>> build() async {
    final allVocab = await ref
        .watch(vocabularyRepositoryProvider)
        .getN5Vocabularies();

    final rawQuery = ref.watch(vocabularySearchQueryProvider);
    final query = rawQuery.trim().toLowerCase();
    final filter = ref.watch(vocabularyFilterProvider);

    return allVocab.where((vocab) {
      // 1. 過濾標籤
      final matchesFilter = filter == null || vocab.tags.contains(filter);
      if (!matchesFilter) return false;

      // 2. 搜尋關鍵字
      if (query.isEmpty) return true;

      return vocab.text.contains(query) ||
          vocab.furigana.contains(query) ||
          vocab.meaning.toLowerCase().contains(query) ||
          vocab.romaji.toLowerCase().contains(query);
    }).toList();
  }

  // TODO: 實作更新學習進度的邏輯
}

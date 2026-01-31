import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/zen_chip_selector.dart';
import '../providers/vocabulary_provider.dart';
import '../widgets/vocabulary_card.dart';
import '../widgets/vocabulary_search_bar.dart';
import 'vocabulary_practice_page.dart';

class VocabularyListPage extends ConsumerWidget {
  const VocabularyListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zenTheme = Theme.of(context).extension<ZenTheme>()!;
    final vocabAsync = ref.watch(vocabularyNotifierProvider);

    return Scaffold(
      backgroundColor: zenTheme.bgPrimary,
      body: CustomScrollView(
        slivers: [
          // 統合式 Header (標題 + 搜尋 + 篩選)
          SliverAppBar(
            pinned: true,
            expandedHeight: 80,
            collapsedHeight: 80,
            toolbarHeight: 0,
            backgroundColor: zenTheme.bgPrimary,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            primary: true,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                bottom: false,
                minimum: const EdgeInsets.only(top: 24, left: 24, right: 24),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'N5 單字學習',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: zenTheme.textPrimary,
                              letterSpacing: 2.0,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '精選 800+ 核心詞彙，成就日檢之路',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: zenTheme.textSecondary.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(110),
              child: Container(
                color: zenTheme.bgPrimary,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 頂部進度條 (無感加載)
                    SizedBox(
                      height: 2,
                      child: vocabAsync.isLoading
                          ? LinearProgressIndicator(
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                zenTheme.accent.withValues(alpha: 0.3),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    SafeArea(
                      top: false,
                      bottom: false,
                      minimum: const EdgeInsets.symmetric(horizontal: 24),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 4,
                        ),
                        child: VocabularySearchBar(),
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final activeFilter = ref.watch(
                          vocabularyFilterProvider,
                        );
                        // 動態獲取單字庫中的所有標籤 (已排除 N5 並排序)
                        final tags = ref.watch(vocabularyAvailableTagsProvider);
                        final options = [null, ...tags];

                        return ZenChipSelector<String?>(
                          options: options,
                          selectedValue: activeFilter,
                          theme: zenTheme,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          labelBuilder: (tag) => tag ?? '全部',
                          onChanged: (tag) {
                            ref
                                .read(vocabularyFilterProvider.notifier)
                                .setFilter(tag);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),

          // 單字列表 - 穩定版 (避免搜尋時閃爍)
          SliverSafeArea(
            top: false,
            // minimum bottom is handled. horizontal is 24.
            minimum: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
            sliver: SliverToBoxAdapter(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: vocabAsync.when(
                  skipLoadingOnRefresh: true,
                  data: (vocabs) {
                    final query = ref.watch(vocabularySearchQueryProvider);
                    final filter = ref.watch(vocabularyFilterProvider);

                    return Padding(
                      key: ValueKey(
                        'vocab_content_${query}_${filter ?? 'all'}',
                      ),
                      padding: const EdgeInsets.only(
                        left: 0,
                        right: 0,
                        bottom: 8,
                      ),
                      child: vocabs.isEmpty
                          ? SizedBox(
                              height: 300,
                              child: Center(
                                child: Text(
                                  '找不到符合的單字',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: zenTheme.textSecondary
                                            .withValues(alpha: 0.5),
                                      ),
                                ),
                              ),
                            )
                          : ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: vocabs.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (context, index) => VocabularyCard(
                                key: ValueKey(vocabs[index].id),
                                vocabulary: vocabs[index],
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          VocabularyPracticePage(
                                            vocabulary: vocabs[index],
                                          ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    );
                  },
                  loading: () => const SizedBox(
                    key: ValueKey('vocab_loading'),
                    height: 300,
                    child: Center(
                      child: Opacity(
                        opacity: 0.5,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),
                  error: (err, stack) => SizedBox(
                    key: const ValueKey('vocab_error'),
                    height: 300,
                    child: Center(child: Text('讀取失敗: $err')),
                  ),
                ),
              ),
            ),
          ),

          // 底部間距
          const SliverSafeArea(
            top: false,
            minimum: EdgeInsets.only(
              bottom: 100,
            ), // Ensure bottom safe area + extra
            sliver: SliverToBoxAdapter(child: SizedBox.shrink()),
          ),
        ],
      ),
    );
  }
}

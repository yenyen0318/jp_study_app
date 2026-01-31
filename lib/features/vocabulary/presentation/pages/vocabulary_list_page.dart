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
    final zen = context.zen;
    final textTheme = Theme.of(context).textTheme;
    final vocabAsync = ref.watch(vocabularyNotifierProvider);

    return Scaffold(
      backgroundColor: zen.bgPrimary,
      body: CustomScrollView(
        slivers: [
          // 統合式 Header (標題 + 搜尋 + 篩選)
          SliverAppBar(
            pinned: true,
            expandedHeight: 80,
            collapsedHeight: 80,
            toolbarHeight: 0,
            backgroundColor: zen.bgPrimary,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            primary: true,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                bottom: false,
                minimum: EdgeInsets.only(
                  top: zen.spacing.lg,
                  left: zen.spacing.lg,
                  right: zen.spacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'N5 單字學習',
                      style: textTheme.headlineMedium?.copyWith(
                        color: zen.textPrimary,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: zen.spacing.xs),
                    Text(
                      '精選 800+ 核心詞彙，成就日檢之路',
                      style: textTheme.bodyMedium?.copyWith(
                        color: zen.textSecondary.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(110),
              child: Container(
                color: zen.bgPrimary,
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
                                zen.accent.withValues(alpha: 0.3),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    SafeArea(
                      top: false,
                      bottom: false,
                      minimum: EdgeInsets.symmetric(horizontal: zen.spacing.lg),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: zen.spacing.xs),
                        child: const VocabularySearchBar(),
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final activeFilter = ref.watch(
                          vocabularyFilterProvider,
                        );
                        final tags = ref.watch(vocabularyAvailableTagsProvider);
                        final options = [null, ...tags];

                        return ZenChipSelector<String?>(
                          options: options,
                          selectedValue: activeFilter,
                          theme: zen,
                          padding: EdgeInsets.symmetric(
                            horizontal: zen.spacing.lg,
                            vertical: zen.spacing.sm,
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
                    SizedBox(height: zen.spacing.sm),
                  ],
                ),
              ),
            ),
          ),

          // 單字列表 - 穩定版
          SliverSafeArea(
            top: false,
            minimum: EdgeInsets.only(
              bottom: zen.spacing.lg,
              left: zen.spacing.lg,
              right: zen.spacing.lg,
            ),
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
                      padding: EdgeInsets.only(bottom: zen.spacing.sm),
                      child: vocabs.isEmpty
                          ? SizedBox(
                              height: 300,
                              child: Center(
                                child: Text(
                                  '找不到符合的單字',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: zen.textSecondary.withValues(
                                      alpha: 0.5,
                                    ),
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
                                  SizedBox(height: zen.spacing.md),
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
          SliverSafeArea(
            top: false,
            minimum: EdgeInsets.only(bottom: zen.spacing.xxl * 2),
            sliver: const SliverToBoxAdapter(child: SizedBox.shrink()),
          ),
        ],
      ),
    );
  }
}

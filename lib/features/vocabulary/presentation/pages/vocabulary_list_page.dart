import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/zen_chip_selector.dart';
import '../../../../core/widgets/zen_page_header.dart';
import '../providers/vocabulary_provider.dart';
import '../widgets/vocabulary_card.dart';
import '../widgets/vocabulary_search_bar.dart';

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
                child: const ZenPageHeader(
                  title: 'N5 單字學習',
                  subtitle: '精選 800+ 核心詞彙，成就日檢之路',
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

          // 單字列表 - 效能優化版
          SliverSafeArea(
            top: false,
            minimum: EdgeInsets.only(
              bottom: zen.spacing.lg,
              left: zen.spacing.lg,
              right: zen.spacing.lg,
            ),
            sliver: vocabAsync.when(
              skipLoadingOnRefresh: true,
              data: (vocabs) {
                return SliverFillRemaining(
                  hasScrollBody: true,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 450),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: vocabs.isEmpty
                        ? Center(
                            key: const ValueKey('vocab_empty'),
                            child: Text(
                              '找不到符合的單字',
                              style: textTheme.bodyLarge?.copyWith(
                                color: zen.textSecondary,
                              ),
                            ),
                          )
                        : ListView.separated(
                            key: ValueKey('vocab_list_${vocabs.length}'),
                            padding: const EdgeInsets.all(0),
                            itemCount: vocabs.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: zen.spacing.md),
                            itemBuilder: (context, index) {
                              final vocab = vocabs[index];
                              return VocabularyCard(
                                key: ValueKey(vocab.id),
                                vocabulary: vocab,
                                onTap: () {
                                  GoRouter.of(
                                    context,
                                  ).push('/vocabulary/practice', extra: vocab);
                                },
                              );
                            },
                          ),
                  ),
                );
              },
              loading: () => const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Opacity(
                    opacity: 0.5,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
              error: (err, stack) => SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text('讀取失敗: $err')),
              ),
            ),
          ),

          // 底部間距
          SliverToBoxAdapter(child: SizedBox(height: zen.spacing.xxl)),
        ],
      ),
    );
  }
}

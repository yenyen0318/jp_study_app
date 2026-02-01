import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/zen_chip_selector.dart';
import '../../../../core/widgets/zen_page_header.dart';
import '../providers/vocabulary_provider.dart';
import '../widgets/vocabulary_card.dart';
import '../widgets/vocabulary_search_bar.dart';
import '../../../../core/widgets/zen_async_builder.dart';

class VocabularyListPage extends ConsumerWidget {
  const VocabularyListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zen = context.zen;
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

          // 單字列表 - 禪意狀態優化版
          SliverSafeArea(
            top: false,
            minimum: EdgeInsets.only(
              bottom: zen.spacing.lg,
              left: zen.spacing.lg,
              right: zen.spacing.lg,
            ),
            sliver: SliverZenAsyncBuilder(
              value: vocabAsync,
              emptyMessage: '沒有找到相關的單字',
              emptySubtitle: '換個關鍵字,說不定會有新發現',
              data: (vocabs) => SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final vocab = vocabs[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == vocabs.length - 1 ? 0 : zen.spacing.md,
                    ),
                    child: VocabularyCard(
                      key: ValueKey(vocab.id),
                      vocabulary: vocab,
                      onTap: () {
                        GoRouter.of(
                          context,
                        ).push('/vocabulary/practice', extra: vocab);
                      },
                    ),
                  );
                }, childCount: vocabs.length),
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

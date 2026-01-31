import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_view_model.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_audio_controller.dart';
import 'package:jp_study_app/core/widgets/zen_toast.dart';
import 'package:jp_study_app/core/errors/exceptions.dart';
import 'package:jp_study_app/features/kana/presentation/widgets/kana_detail_sheet.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana_type.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana_category.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_filter_provider.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_type_filter_provider.dart';
import 'package:jp_study_app/core/widgets/zen_segmented_button.dart';
import 'package:jp_study_app/core/widgets/zen_chip_selector.dart';
import 'package:jp_study_app/core/widgets/zen_page_header.dart';
import 'package:jp_study_app/core/widgets/zen_card.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_groups_provider.dart';

class KanaListPage extends ConsumerWidget {
  const KanaListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zen = context.zen;
    final groupsAsync = ref.watch(filteredKanaGroupsProvider);
    final selectedCategory = ref.watch(kanaCategoryFilterProvider);

    // 監聽音效錯誤狀態
    ref.listen<AsyncValue<void>>(kanaAudioControllerProvider, (previous, next) {
      if (next.hasError) {
        final error = next.error;
        String message = '播放失敗';
        if (error is TtsException) {
          message = error.message;
        }
        ZenToast.show(context, message);
      }
    });

    return Scaffold(
      backgroundColor: zen.bgPrimary,
      body: CustomScrollView(
        slivers: [
          // 頂部標題與過濾器
          SliverSafeArea(
            bottom: false,
            minimum: EdgeInsets.only(top: zen.spacing.lg),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: zen.layout.maxContentWidth,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: zen.spacing.lg,
                        ),
                        child: ZenPageHeader(
                          title: '五十音',
                          trailing: ZenSegmentedButton<KanaType>(
                            options: const [
                              KanaType.hiragana,
                              KanaType.katakana,
                            ],
                            selectedValue: ref.watch(kanaTypeFilterProvider),
                            onChanged: (type) {
                              ref
                                  .read(kanaTypeFilterProvider.notifier)
                                  .setType(type);
                            },
                            theme: zen,
                            labelBuilder: (type) =>
                                type == KanaType.hiragana ? 'あ' : 'ア',
                          ),
                        ),
                      ),
                      SizedBox(height: zen.spacing.lg),
                      ZenChipSelector<KanaCategory>(
                        options: KanaCategory.values,
                        selectedValue: selectedCategory,
                        padding: EdgeInsets.symmetric(
                          horizontal: zen.spacing.lg,
                        ),
                        onChanged: (category) {
                          ref
                              .read(kanaCategoryFilterProvider.notifier)
                              .setFilter(category);
                        },
                        theme: zen,
                        labelBuilder: (category) => category.label,
                      ),
                      SizedBox(height: zen.spacing.sm),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 假名列表內容 - 優化版
          groupsAsync.when(
            data: (groups) => SliverFillRemaining(
              hasScrollBody: true,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: CustomScrollView(
                  key: ValueKey(
                    '${ref.watch(kanaTypeFilterProvider)}_${selectedCategory.name}',
                  ),
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: zen.spacing.lg),
                      sliver: SliverMainAxisGroup(
                        slivers: [
                          for (final group in groups) ...[
                            SliverToBoxAdapter(
                              child: Center(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: zen.layout.maxContentWidth,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: zen.spacing.md,
                                      bottom: zen.spacing.md,
                                    ),
                                    child: _CategoryHeader(
                                      title: group.title,
                                      description: group.description,
                                      zen: zen,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            _SliverKanaGrid(
                              kanaList: group.items,
                              zen: zen,
                              crossAxisCount: group.crossAxisCount,
                              onTap: (kana) {
                                ref
                                    .read(kanaAudioControllerProvider.notifier)
                                    .play(kana.text);
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  builder: (context) => Consumer(
                                    builder: (context, ref, child) {
                                      final allKana = ref.watch(
                                        kanaListViewModelProvider,
                                      );
                                      return allKana.maybeWhen(
                                        data: (list) => KanaDetailSheet(
                                          kana: kana,
                                          similarKana: list
                                              .where(
                                                (k) => kana.similarKanaIds
                                                    .contains(k.id),
                                              )
                                              .toList(),
                                          onPlayAudio: () {
                                            ref
                                                .read(
                                                  kanaAudioControllerProvider
                                                      .notifier,
                                                )
                                                .play(kana.text);
                                          },
                                        ),
                                        orElse: () => const SizedBox.shrink(),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                            SliverToBoxAdapter(
                              child: SizedBox(height: zen.spacing.xl),
                            ),
                          ],
                        ],
                      ),
                    ),
                    // 額外的底部留白，確保 CustomScrollView 能正常捲動
                    SliverToBoxAdapter(
                      child: SizedBox(height: zen.spacing.xxl),
                    ),
                  ],
                ),
              ),
            ),
            loading: () =>
                const SliverFillRemaining(child: Center(child: Text('準備中...'))),
            error: (err, stack) =>
                const SliverFillRemaining(child: Center(child: Text('發生錯誤'))),
          ),

          SliverSafeArea(
            top: false,
            minimum: EdgeInsets.only(bottom: zen.spacing.xxl),
            sliver: const SliverToBoxAdapter(child: SizedBox.shrink()),
          ),
        ],
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  final String title;
  final String? description;
  final ZenTheme zen;

  const _CategoryHeader({
    required this.title,
    this.description,
    required this.zen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w400,
            color: zen.textPrimary.withValues(alpha: 0.9),
            letterSpacing: 2.0,
          ),
        ),
        if (description != null) ...[
          SizedBox(height: zen.spacing.xs),
          Text(
            description!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w300,
              color: zen.textSecondary.withValues(alpha: 0.8),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ],
    );
  }
}

class _SliverKanaGrid extends StatelessWidget {
  final List<Kana> kanaList;
  final ZenTheme zen;
  final int crossAxisCount;
  final Function(Kana) onTap;

  const _SliverKanaGrid({
    required this.kanaList,
    required this.zen,
    required this.crossAxisCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        // 使用設計系統中定義的 maxContentWidth
        final double maxWidth = zen.layout.maxContentWidth;
        final double screenWidth = constraints.crossAxisExtent;
        final double gridWidth = screenWidth > maxWidth
            ? maxWidth
            : screenWidth;

        final double gap = zen.spacing.md;
        const int baseCols = 5;

        final double baseItemWidth =
            (gridWidth - (baseCols - 1) * gap) / baseCols;
        final double baseItemHeight = baseItemWidth;

        final double currentItemWidth =
            (gridWidth - (crossAxisCount - 1) * gap) / crossAxisCount;

        final double childAspectRatio = currentItemWidth / baseItemHeight;

        // 如果螢幕太寬，我們需要置中 Grid。SliverPadding 可以幫忙。
        final double horizontalPadding = (screenWidth - gridWidth) / 2;

        return SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: gap,
              crossAxisSpacing: gap,
              childAspectRatio: childAspectRatio,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final kana = kanaList[index];
              return _KanaCard(kana: kana, zen: zen, onTap: () => onTap(kana));
            }, childCount: kanaList.length),
          ),
        );
      },
    );
  }
}

class _KanaCard extends StatelessWidget {
  final Kana kana;
  final ZenTheme zen;
  final VoidCallback? onTap;

  const _KanaCard({required this.kana, required this.zen, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ZenCard(
      onTap: onTap,
      child: Stack(
        children: [
          Center(
            child: Text(
              kana.text,
              style:
                  (kana.text.length > 1
                          ? Theme.of(context).textTheme.headlineMedium
                          : Theme.of(context).textTheme.headlineLarge)
                      ?.copyWith(
                        height: zen.typography.lineHeightNormal,
                        color: kana.isDuplicate
                            ? zen.textPrimary.withValues(alpha: 0.2)
                            : zen.textPrimary,
                      ),
            ),
          ),
          Positioned(
            bottom: zen.spacing.xs,
            right: zen.spacing.sm,
            child: Text(
              kana.romaji,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: kana.isDuplicate
                    ? zen.textSecondary.withValues(alpha: 0.2)
                    : zen.textSecondary,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

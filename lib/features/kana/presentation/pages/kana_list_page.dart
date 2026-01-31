import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_view_model.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_audio_controller.dart';
import 'package:jp_study_app/core/widgets/zen_toast.dart';
import 'package:jp_study_app/core/errors/exceptions.dart';
import 'package:jp_study_app/features/kana/presentation/widgets/kana_detail_sheet.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_filter_provider.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_type_filter_provider.dart';
import 'package:jp_study_app/core/widgets/zen_segmented_button.dart';
import 'package:jp_study_app/core/widgets/zen_chip_selector.dart';

class KanaListPage extends ConsumerWidget {
  const KanaListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zen = context.zen;
    final textTheme = Theme.of(context).textTheme;
    final kanaListAsync = ref.watch(kanaListViewModelProvider);
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
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: zen.spacing.lg,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '五十音',
                              style: textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.w300,
                                color: zen.textPrimary,
                                letterSpacing: 2.0,
                              ),
                            ),
                            // 假名類型切換 - 使用 ZenSegmentedButton
                            ZenSegmentedButton<KanaType>(
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
                          ],
                        ),
                      ),
                      SizedBox(height: zen.spacing.lg),
                      // 分類選擇 - 使用 ZenChipSelector
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

          // 假名列表內容
          SliverSafeArea(
            top: false,
            minimum: EdgeInsets.only(bottom: zen.spacing.lg),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Padding(
                      key: ValueKey(
                        '${ref.watch(kanaTypeFilterProvider)}_${selectedCategory.name}',
                      ),
                      padding: EdgeInsets.symmetric(vertical: zen.spacing.md),
                      child: kanaListAsync.when(
                        data: (kanaList) {
                          final seion = kanaList
                              .where((k) => k.row >= 0 && k.row <= 9)
                              .toList();
                          final bion = kanaList
                              .where((k) => k.row == 10)
                              .toList();
                          final dakuon = kanaList
                              .where((k) => k.row >= 11 && k.row <= 14)
                              .toList();
                          final handakuon = kanaList
                              .where((k) => k.row == 15)
                              .toList();
                          final youon = kanaList
                              .where((k) => k.row >= 16 && k.row <= 26)
                              .toList();
                          final sokuon = kanaList
                              .where(
                                (k) => k.row == 100 && k.id.contains('sokuon'),
                              )
                              .toList();
                          final choon = kanaList
                              .where((k) => k.row == 101)
                              .toList();
                          final modern = kanaList
                              .where((k) => k.row >= 110)
                              .toList();

                          final showSeion =
                              selectedCategory == KanaCategory.all ||
                              selectedCategory == KanaCategory.seion;
                          final showDakuon =
                              selectedCategory == KanaCategory.all ||
                              selectedCategory == KanaCategory.dakuon;
                          final showHandakuon =
                              selectedCategory == KanaCategory.all ||
                              selectedCategory == KanaCategory.handakuon;
                          final showYouon =
                              selectedCategory == KanaCategory.all ||
                              selectedCategory == KanaCategory.youon;
                          final showSokuon =
                              selectedCategory == KanaCategory.all ||
                              selectedCategory == KanaCategory.sokuon;
                          final showChoon =
                              selectedCategory == KanaCategory.all ||
                              selectedCategory == KanaCategory.choon;
                          final showModern =
                              selectedCategory == KanaCategory.all ||
                              selectedCategory == KanaCategory.modern;

                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: zen.spacing.lg,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (showSeion && seion.isNotEmpty) ...[
                                  _CategoryHeader(
                                    title: KanaCategory.seion.label,
                                    description: KanaCategory.seion.description,
                                    zen: zen,
                                  ),
                                  SizedBox(height: zen.spacing.md),
                                  _KanaGrid(
                                    kanaList: seion,
                                    allKana: kanaList,
                                    ref: ref,
                                    zen: zen,
                                  ),
                                  SizedBox(height: zen.spacing.xl),
                                ],
                                if (showSeion && bion.isNotEmpty) ...[
                                  _CategoryHeader(
                                    title: '鼻音',
                                    description: '最後一個鼻音發音',
                                    zen: zen,
                                  ),
                                  SizedBox(height: zen.spacing.md),
                                  _KanaGrid(
                                    kanaList: bion,
                                    allKana: kanaList,
                                    ref: ref,
                                    zen: zen,
                                  ),
                                  SizedBox(height: zen.spacing.xl),
                                ],
                                if (showDakuon && dakuon.isNotEmpty) ...[
                                  _CategoryHeader(
                                    title: KanaCategory.dakuon.label,
                                    description:
                                        KanaCategory.dakuon.description,
                                    zen: zen,
                                  ),
                                  SizedBox(height: zen.spacing.md),
                                  _KanaGrid(
                                    kanaList: dakuon,
                                    allKana: kanaList,
                                    ref: ref,
                                    zen: zen,
                                  ),
                                  SizedBox(height: zen.spacing.xl),
                                ],
                                if (showHandakuon && handakuon.isNotEmpty) ...[
                                  _CategoryHeader(
                                    title: KanaCategory.handakuon.label,
                                    description:
                                        KanaCategory.handakuon.description,
                                    zen: zen,
                                  ),
                                  SizedBox(height: zen.spacing.md),
                                  _KanaGrid(
                                    kanaList: handakuon,
                                    allKana: kanaList,
                                    ref: ref,
                                    zen: zen,
                                  ),
                                  SizedBox(height: zen.spacing.xl),
                                ],
                                if (showYouon && youon.isNotEmpty) ...[
                                  _CategoryHeader(
                                    title: KanaCategory.youon.label,
                                    description: KanaCategory.youon.description,
                                    zen: zen,
                                  ),
                                  SizedBox(height: zen.spacing.md),
                                  _KanaGrid(
                                    kanaList: youon,
                                    allKana: kanaList,
                                    ref: ref,
                                    zen: zen,
                                    crossAxisCount: 3,
                                  ),
                                  SizedBox(height: zen.spacing.xl),
                                ],
                                if (showSokuon && sokuon.isNotEmpty) ...[
                                  _CategoryHeader(
                                    title: KanaCategory.sokuon.label,
                                    description:
                                        KanaCategory.sokuon.description,
                                    zen: zen,
                                  ),
                                  SizedBox(height: zen.spacing.md),
                                  _KanaGrid(
                                    kanaList: sokuon,
                                    allKana: kanaList,
                                    ref: ref,
                                    zen: zen,
                                    crossAxisCount: 3,
                                  ),
                                  SizedBox(height: zen.spacing.xl),
                                ],
                                if (showChoon && choon.isNotEmpty) ...[
                                  _CategoryHeader(
                                    title: KanaCategory.choon.label,
                                    description: KanaCategory.choon.description,
                                    zen: zen,
                                  ),
                                  SizedBox(height: zen.spacing.md),
                                  _KanaGrid(
                                    kanaList: choon,
                                    allKana: kanaList,
                                    ref: ref,
                                    zen: zen,
                                    crossAxisCount: 3,
                                  ),
                                  SizedBox(height: zen.spacing.xl),
                                ],
                                if (showModern && modern.isNotEmpty) ...[
                                  _CategoryHeader(
                                    title: KanaCategory.modern.label,
                                    description:
                                        KanaCategory.modern.description,
                                    zen: zen,
                                  ),
                                  SizedBox(height: zen.spacing.md),
                                  _KanaGrid(
                                    kanaList: modern,
                                    allKana: kanaList,
                                    ref: ref,
                                    zen: zen,
                                    crossAxisCount: 3,
                                  ),
                                  SizedBox(height: zen.spacing.xl),
                                ],
                              ],
                            ),
                          );
                        },
                        loading: () => const SizedBox(
                          height: 200,
                          child: Center(child: Text('準備中...')),
                        ),
                        error: (err, stack) => const SizedBox(
                          height: 200,
                          child: Center(child: Text('發生錯誤')),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverSafeArea(
            top: false,
            minimum: EdgeInsets.only(bottom: zen.spacing.xxl * 1.5),
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
            height: 1.2,
            fontSize: 18,
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

class _KanaGrid extends StatelessWidget {
  final List<Kana> kanaList;
  final List<Kana> allKana;
  final WidgetRef ref;
  final ZenTheme zen;
  final int crossAxisCount;

  const _KanaGrid({
    required this.kanaList,
    required this.allKana,
    required this.ref,
    required this.zen,
    this.crossAxisCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            final double gap = zen.spacing.sm + zen.spacing.xs; // 12.0
            const int baseCols = 5;

            final double baseItemWidth =
                (width - (baseCols - 1) * gap) / baseCols;
            final double baseItemHeight = baseItemWidth;

            final double currentItemWidth =
                (width - (crossAxisCount - 1) * gap) / crossAxisCount;

            final double childAspectRatio = currentItemWidth / baseItemHeight;

            return GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: gap,
                crossAxisSpacing: gap,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: kanaList.length,
              itemBuilder: (context, index) {
                final kana = kanaList[index];
                return _KanaCard(
                  kana: kana,
                  zen: zen,
                  onTap: () {
                    ref
                        .read(kanaAudioControllerProvider.notifier)
                        .play(kana.text);
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => KanaDetailSheet(
                        kana: kana,
                        similarKana: allKana
                            .where((k) => kana.similarKanaIds.contains(k.id))
                            .toList(),
                        onPlayAudio: () {
                          ref
                              .read(kanaAudioControllerProvider.notifier)
                              .play(kana.text);
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _KanaCard extends StatelessWidget {
  final Kana vocabulary; // 這裡的原參數名為 kana，但為了符合代幣命名習慣或保持一致性，也可考慮調整
  final ZenTheme zen;
  final VoidCallback? onTap;

  // 修正：這裡的原參數名是 kana，我維持原名以免破壞外部調用，但內部使用 zen
  final Kana kana;

  const _KanaCard({required this.kana, required this.zen, this.onTap})
    : vocabulary = kana;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(zen.radius.md),
      child: Container(
        decoration: BoxDecoration(
          color: zen.bgSurface,
          borderRadius: BorderRadius.circular(zen.radius.md),
          border: Border.all(color: zen.borderSubtle, width: 0.5),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                kana.text,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: kana.text.length > 1 ? 26 : 32,
                  height: 1.25,
                  color: kana.isDuplicate
                      ? zen.textPrimary.withValues(alpha: 0.2)
                      : zen.textPrimary,
                ),
              ),
            ),
            Positioned(
              bottom: zen.spacing.xs + 2,
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
      ),
    );
  }
}

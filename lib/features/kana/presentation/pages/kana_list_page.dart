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
    final zenTheme = Theme.of(context).extension<ZenTheme>()!;
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
      backgroundColor: zenTheme.bgPrimary,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: CustomScrollView(
            slivers: [
              // 頂部標題與過濾器
              SliverSafeArea(
                bottom: false,
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '五十音',
                                style: Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: zenTheme.textPrimary,
                                      letterSpacing: 2.0,
                                    ),
                              ),
                              // 假名類型切換 - 使用 ZenSegmentedButton
                              ZenSegmentedButton<KanaType>(
                                options: const [
                                  KanaType.hiragana,
                                  KanaType.katakana,
                                ],
                                selectedValue: ref.watch(
                                  kanaTypeFilterProvider,
                                ),
                                onChanged: (type) {
                                  ref
                                      .read(kanaTypeFilterProvider.notifier)
                                      .setType(type);
                                },
                                theme: zenTheme,
                                labelBuilder: (type) =>
                                    type == KanaType.hiragana ? 'あ' : 'ア',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // 分類選擇 - 使用 ZenChipSelector
                        ZenChipSelector<KanaCategory>(
                          options: KanaCategory.values,
                          selectedValue: selectedCategory,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          onChanged: (category) {
                            ref
                                .read(kanaCategoryFilterProvider.notifier)
                                .setFilter(category);
                          },
                          theme: zenTheme,
                          labelBuilder: (category) => category.label,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),

              // 假名列表內容
              SliverToBoxAdapter(
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
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

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (showSeion && seion.isNotEmpty) ...[
                              _CategoryHeader(
                                title: KanaCategory.seion.label,
                                description: KanaCategory.seion.description,
                                theme: zenTheme,
                              ),
                              const SizedBox(height: 16),
                              _KanaGrid(
                                kanaList: seion,
                                allKana: kanaList,
                                ref: ref,
                                zenTheme: zenTheme,
                              ),
                              const SizedBox(height: 32),
                            ],
                            if (showSeion && bion.isNotEmpty) ...[
                              _CategoryHeader(
                                title: '鼻音',
                                description: '最後一個鼻音發音',
                                theme: zenTheme,
                              ),
                              const SizedBox(height: 16),
                              _KanaGrid(
                                kanaList: bion,
                                allKana: kanaList,
                                ref: ref,
                                zenTheme: zenTheme,
                              ),
                              const SizedBox(height: 32),
                            ],
                            if (showDakuon && dakuon.isNotEmpty) ...[
                              _CategoryHeader(
                                title: KanaCategory.dakuon.label,
                                description: KanaCategory.dakuon.description,
                                theme: zenTheme,
                              ),
                              const SizedBox(height: 16),
                              _KanaGrid(
                                kanaList: dakuon,
                                allKana: kanaList,
                                ref: ref,
                                zenTheme: zenTheme,
                              ),
                              const SizedBox(height: 32),
                            ],
                            if (showHandakuon && handakuon.isNotEmpty) ...[
                              _CategoryHeader(
                                title: KanaCategory.handakuon.label,
                                description: KanaCategory.handakuon.description,
                                theme: zenTheme,
                              ),
                              const SizedBox(height: 16),
                              _KanaGrid(
                                kanaList: handakuon,
                                allKana: kanaList,
                                ref: ref,
                                zenTheme: zenTheme,
                              ),
                              const SizedBox(height: 32),
                            ],
                            if (showYouon && youon.isNotEmpty) ...[
                              _CategoryHeader(
                                title: KanaCategory.youon.label,
                                description: KanaCategory.youon.description,
                                theme: zenTheme,
                              ),
                              const SizedBox(height: 16),
                              _KanaGrid(
                                kanaList: youon,
                                allKana: kanaList,
                                ref: ref,
                                zenTheme: zenTheme,
                                crossAxisCount: 3,
                              ),
                              const SizedBox(height: 32),
                            ],
                            if (showSokuon && sokuon.isNotEmpty) ...[
                              _CategoryHeader(
                                title: KanaCategory.sokuon.label,
                                description: KanaCategory.sokuon.description,
                                theme: zenTheme,
                              ),
                              const SizedBox(height: 16),
                              _KanaGrid(
                                kanaList: sokuon,
                                allKana: kanaList,
                                ref: ref,
                                zenTheme: zenTheme,
                                crossAxisCount: 3,
                              ),
                              const SizedBox(height: 32),
                            ],
                            if (showChoon && choon.isNotEmpty) ...[
                              _CategoryHeader(
                                title: KanaCategory.choon.label,
                                description: KanaCategory.choon.description,
                                theme: zenTheme,
                              ),
                              const SizedBox(height: 16),
                              _KanaGrid(
                                kanaList: choon,
                                allKana: kanaList,
                                ref: ref,
                                zenTheme: zenTheme,
                                crossAxisCount: 3,
                              ),
                              const SizedBox(height: 32),
                            ],
                            if (showModern && modern.isNotEmpty) ...[
                              _CategoryHeader(
                                title: KanaCategory.modern.label,
                                description: KanaCategory.modern.description,
                                theme: zenTheme,
                              ),
                              const SizedBox(height: 16),
                              _KanaGrid(
                                kanaList: modern,
                                allKana: kanaList,
                                ref: ref,
                                zenTheme: zenTheme,
                                crossAxisCount: 3,
                              ),
                              const SizedBox(height: 32),
                            ],
                          ],
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

              const SliverSafeArea(
                top: false,
                minimum: EdgeInsets.only(bottom: 80),
                sliver: SliverToBoxAdapter(child: SizedBox.shrink()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  final String title;
  final String? description;
  final ZenTheme theme;

  const _CategoryHeader({
    required this.title,
    this.description,
    required this.theme,
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
            color: theme.textPrimary.withValues(alpha: 0.9),
            letterSpacing: 2.0,
            height: 1.2,
            fontSize: 18, // 微調保持原設計
          ),
        ),
        if (description != null) ...[
          const SizedBox(height: 6),
          Text(
            description!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w300,
              color: theme.textSecondary.withValues(alpha: 0.8),
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
  final ZenTheme zenTheme;
  final int crossAxisCount;

  const _KanaGrid({
    required this.kanaList,
    required this.allKana,
    required this.ref,
    required this.zenTheme,
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
            const double gap = 12.0;
            const int baseCols = 5;

            // 計算標準 5 欄卡片的寬度與高度 (基準比例 1.0)
            final double baseItemWidth =
                (width - (baseCols - 1) * gap) / baseCols;
            final double baseItemHeight = baseItemWidth;

            // 計算當前欄數下的卡片寬度
            final double currentItemWidth =
                (width - (crossAxisCount - 1) * gap) / crossAxisCount;

            // 動態計算長寬比:讓高度始終等於 baseItemHeight
            final double childAspectRatio = currentItemWidth / baseItemHeight;

            return GridView.builder(
              padding: EdgeInsets.zero, // 移除 GridView 預設內距
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
                  theme: zenTheme,
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
  final Kana kana;
  final ZenTheme theme;
  final VoidCallback? onTap;

  const _KanaCard({required this.kana, required this.theme, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: theme.bgSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.borderSubtle, width: 0.5),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                kana.text,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  // 動態調整大小
                  fontSize: kana.text.length > 1 ? 26 : 32,
                  height: 1.25,
                  color: kana.isDuplicate
                      ? theme.textPrimary.withValues(alpha: 0.2)
                      : theme.textPrimary,
                ),
              ),
            ),
            Positioned(
              bottom: 6,
              right: 8,
              child: Text(
                kana.romaji,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: kana.isDuplicate
                      ? theme.textSecondary.withValues(alpha: 0.2)
                      : theme.textSecondary,
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

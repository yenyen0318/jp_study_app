import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_view_model.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_audio_controller.dart';
import 'package:jp_study_app/core/widgets/zen_toast.dart';
import 'package:jp_study_app/core/errors/exceptions.dart';
import 'package:jp_study_app/features/exam/presentation/widgets/exam_scope_dialog.dart';
import 'package:jp_study_app/features/kana/presentation/widgets/kana_detail_sheet.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_filter_provider.dart';
import 'package:jp_study_app/core/widgets/zen_button.dart';
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
              SliverSafeArea(
                bottom: false,
                sliver: SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '五十音',
                              style: GoogleFonts.notoSansTc(
                                fontSize: 32,
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
                              selectedValue: ref.watch(kanaTypeFilterProvider),
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
                        const SizedBox(height: 24),
                        // 分類選擇 - 使用 ZenChipSelector
                        ZenChipSelector<KanaCategory>(
                          options: KanaCategory.values,
                          selectedValue: selectedCategory,
                          onChanged: (category) {
                            ref
                                .read(kanaCategoryFilterProvider.notifier)
                                .setFilter(category);
                          },
                          theme: zenTheme,
                          labelBuilder: (category) => category.label,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 使用 AnimatedSwitcher 實作淡入淡出過渡動畫
              // 符合禪意美學:平靜的視覺過渡,避免生硬的切換
              SliverToBoxAdapter(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: kanaListAsync.when(
                    data: (kanaList) {
                      final seion = kanaList
                          .where((k) => k.row >= 0 && k.row <= 9)
                          .toList();
                      final bion = kanaList.where((k) => k.row == 10).toList();
                      final dakuon = kanaList
                          .where((k) => k.row >= 11 && k.row <= 14)
                          .toList();
                      final handakuon = kanaList
                          .where((k) => k.row == 15)
                          .toList();
                      final youon = kanaList
                          .where((k) => k.row >= 16 && k.row <= 26)
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

                      return Padding(
                        key: ValueKey(ref.watch(kanaTypeFilterProvider)),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (showSeion && seion.isNotEmpty) ...[
                              _CategoryHeader(title: '清音', theme: zenTheme),
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
                              _CategoryHeader(title: '鼻音', theme: zenTheme),
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
                              _CategoryHeader(title: '濁音', theme: zenTheme),
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
                              _CategoryHeader(title: '半濁音', theme: zenTheme),
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
                              _CategoryHeader(title: '拗音', theme: zenTheme),
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
                          ],
                        ),
                      );
                    },
                    loading: () => const SizedBox(
                      key: ValueKey('loading'),
                      height: 200,
                      child: Center(child: Text('準備中...')),
                    ),
                    error: (err, stack) => const SizedBox(
                      key: ValueKey('error'),
                      height: 200,
                      child: Center(child: Text('發生錯誤')),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16, right: 8),
        child: ZenButton(
          label: '驗收',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const ExamScopeDialog(),
            );
          },
          theme: zenTheme,
        ),
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  final String title;
  final ZenTheme theme;

  const _CategoryHeader({required this.title, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.notoSansTc(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: theme.textSecondary,
        letterSpacing: 4.0,
        height: 1.2, // 收緊文字行高
      ),
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
                style: GoogleFonts.notoSansJp(
                  fontSize: kana.text.length > 1 ? 26 : 32,
                  height: 1.25, // 收緊行高以避免無效空間
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
                style: GoogleFonts.notoSansTc(
                  fontSize: 11,
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

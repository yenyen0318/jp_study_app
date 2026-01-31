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
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        const SizedBox(height: 24),
                        _CategorySelector(
                          selectedCategory: selectedCategory,
                          onCategorySelected: (category) {
                            ref
                                .read(kanaCategoryFilterProvider.notifier)
                                .setFilter(category);
                          },
                          theme: zenTheme,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SliverSafeArea(
                top: false,
                bottom: false,
                sliver: kanaListAsync.when(
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

                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
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
                            ),
                            const SizedBox(height: 32),
                          ],
                        ]),
                      ),
                    );
                  },
                  loading: () => const SliverFillRemaining(
                    child: Center(child: Text('準備中...')),
                  ),
                  error: (err, stack) => const SliverFillRemaining(
                    child: Center(child: Text('發生錯誤')),
                  ),
                ),
              ),
              const SliverSafeArea(
                top: false,
                minimum: EdgeInsets.only(bottom: 24),
                sliver: SliverToBoxAdapter(child: SizedBox.shrink()),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16, right: 8),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => const ExamScopeDialog(),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: zenTheme.bgSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: zenTheme.borderSubtle, width: 0.5),
              boxShadow: [
                BoxShadow(
                  color: zenTheme.textPrimary.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              '驗收',
              style: GoogleFonts.notoSansTc(
                fontSize: 14,
                color: zenTheme.textPrimary,
                fontWeight: FontWeight.w300,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategorySelector extends StatelessWidget {
  final KanaCategory selectedCategory;
  final Function(KanaCategory) onCategorySelected;
  final ZenTheme theme;

  const _CategorySelector({
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: KanaCategory.values.map((category) {
          final isSelected = category == selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(
                category.label,
                style: GoogleFonts.notoSansTc(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
                  color: isSelected ? theme.bgPrimary : theme.textSecondary,
                ),
              ),
              selected: isSelected,
              onSelected: (_) => onCategorySelected(category),
              selectedColor: theme.textPrimary,
              backgroundColor: theme.bgSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? Colors.transparent : theme.borderSubtle,
                  width: 0.5,
                ),
              ),
              showCheckmark: false,
              padding: const EdgeInsets.symmetric(horizontal: 4),
            ),
          );
        }).toList(),
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
      ),
    );
  }
}

class _KanaGrid extends StatelessWidget {
  final List<Kana> kanaList;
  final List<Kana> allKana;
  final WidgetRef ref;
  final ZenTheme zenTheme;

  const _KanaGrid({
    required this.kanaList,
    required this.allKana,
    required this.ref,
    required this.zenTheme,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.0,
      ),
      itemCount: kanaList.length,
      itemBuilder: (context, index) {
        final kana = kanaList[index];
        return _KanaCard(
          kana: kana,
          theme: zenTheme,
          onTap: () {
            ref.read(kanaAudioControllerProvider.notifier).play(kana.text);
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
                  fontSize: 32,
                  height: 1.6, // 預留標音/間距空間
                  color: kana.isDuplicate
                      ? theme.textPrimary.withValues(alpha: 0.2)
                      : theme.textPrimary,
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 12,
              child: Text(
                kana.romaji,
                style: GoogleFonts.notoSansTc(
                  fontSize: 12,
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

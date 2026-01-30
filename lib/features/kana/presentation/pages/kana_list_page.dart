import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_view_model.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_audio_controller.dart';
import 'package:jp_study_app/core/widgets/zen_toast.dart';
import 'package:jp_study_app/core/errors/exceptions.dart';

class KanaListPage extends ConsumerWidget {
  const KanaListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zenTheme = Theme.of(context).extension<ZenTheme>()!;
    final kanaListAsync = ref.watch(kanaListViewModelProvider);

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
                    child: Text(
                      '五十音', // 50 音列表
                      style: GoogleFonts.notoSansTc(
                        fontSize: 32,
                        fontWeight: FontWeight.w300, // 輕盈/禪意風格
                        color: zenTheme.textPrimary,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
              ),

              SliverSafeArea(
                top: false,
                bottom: false,
                sliver: SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: kanaListAsync.when(
                    data: (kanaList) => SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 100,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 1.0,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final kana = kanaList[index];
                        return _KanaCard(
                          kana: kana,
                          theme: zenTheme,
                          onTap: () {
                            ref
                                .read(kanaAudioControllerProvider.notifier)
                                .play(kana.text);
                          },
                        );
                      }, childCount: kanaList.length),
                    ),
                    loading: () => SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          '準備中...',
                          style: GoogleFonts.notoSansTc(
                            color: zenTheme.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    error: (err, stack) => SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          '發生錯誤',
                          style: GoogleFonts.notoSansTc(color: zenTheme.error),
                        ),
                      ),
                    ),
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
                  color: theme.textPrimary,
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
                  color: theme.textSecondary,
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

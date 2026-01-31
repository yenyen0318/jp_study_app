import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/core/widgets/zen_canvas.dart';

class KanaDetailSheet extends StatelessWidget {
  final Kana kana;
  final List<Kana> similarKana;
  final VoidCallback onPlayAudio;

  const KanaDetailSheet({
    super.key,
    required this.kana,
    this.similarKana = const [],
    required this.onPlayAudio,
  });

  @override
  Widget build(BuildContext context) {
    final zenTheme = Theme.of(context).extension<ZenTheme>()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: zenTheme.bgPrimary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 頂部導覽條 (手勢提示)
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: zenTheme.borderSubtle,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 核心展示區
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  kana.text,
                  style: GoogleFonts.notoSansJp(
                    fontSize: 80,
                    fontWeight: FontWeight.w300,
                    color: zenTheme.textPrimary,
                  ),
                ),
                const SizedBox(width: 16),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kana.romaji,
                        style: GoogleFonts.notoSansTc(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                          color: zenTheme.textSecondary,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      InkWell(
                        onTap: onPlayAudio,
                        child: Row(
                          children: [
                            Icon(
                              Icons.volume_up_outlined,
                              size: 18,
                              color: zenTheme.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '發音',
                              style: GoogleFonts.notoSansTc(
                                fontSize: 14,
                                color: zenTheme.textSecondary,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
            _Divider(theme: zenTheme),
            const SizedBox(height: 24),

            // 助記故事
            if (kana.mnemonic != null) ...[
              _SectionHeader(title: '記憶小撇步', theme: zenTheme),
              const SizedBox(height: 12),
              Text(
                kana.mnemonic!,
                style: GoogleFonts.notoSansTc(
                  fontSize: 16,
                  height: 1.6,
                  color: zenTheme.textPrimary,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 32),
            ],

            // 手寫練習 (新增量點)
            _SectionHeader(title: '嘗試寫寫看', theme: zenTheme),
            const SizedBox(height: 16),
            ZenCanvas(
              guideText: kana.text,
              strokes: kana.strokes,
              theme: zenTheme,
              height: 240,
            ),
            const SizedBox(height: 32),

            // 相似字對比
            if (similarKana.isNotEmpty) ...[
              _SectionHeader(title: '容易混淆', theme: zenTheme),
              const SizedBox(height: 16),
              SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: similarKana.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final s = similarKana[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: zenTheme.borderSubtle,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            s.text,
                            style: GoogleFonts.notoSansJp(
                              fontSize: 24,
                              color: zenTheme.textPrimary,
                            ),
                          ),
                          Text(
                            s.romaji,
                            style: GoogleFonts.notoSansTc(
                              fontSize: 10,
                              color: zenTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
            ],

            // 底部間距
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final ZenTheme theme;

  const _SectionHeader({required this.title, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: theme.borderSubtle,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.notoSansTc(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: theme.textSecondary,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  final ZenTheme theme;
  const _Divider({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      width: double.infinity,
      color: theme.borderSubtle.withValues(alpha: 0.5),
    );
  }
}

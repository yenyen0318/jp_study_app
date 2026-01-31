import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_study_app/core/theme/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final zenTheme = Theme.of(context).extension<ZenTheme>()!;

    return Scaffold(
      backgroundColor: zenTheme.bgPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _HomeNavItem(
              title: '五十音',
              subtitle: 'かな',
              onTap: () => context.push('/kana'),
              theme: zenTheme,
            ),
            const SizedBox(height: 48),
            _HomeNavItem(
              title: '單字',
              subtitle: 'ことば',
              onTap: () => context.push('/vocabulary'),
              theme: zenTheme,
            ),
            const SizedBox(height: 48),
            _HomeNavItem(
              title: '測驗',
              subtitle: 'しけん',
              onTap: () => context.push('/exam_setup'),
              theme: zenTheme,
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeNavItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final ZenTheme theme;

  const _HomeNavItem({
    required this.title,
    required this.subtitle,
    this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;

    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.notoSansTc(
              fontSize: 36,
              fontWeight: FontWeight.w300,
              color: isEnabled
                  ? theme.textPrimary
                  : theme.textPrimary.withValues(alpha: 0.2),
              letterSpacing: 8.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: GoogleFonts.notoSansJp(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isEnabled
                  ? theme.textSecondary.withValues(alpha: 0.7)
                  : theme.textSecondary.withValues(alpha: 0.1),
              letterSpacing: 4.0,
            ),
          ),
        ],
      ),
    );
  }
}

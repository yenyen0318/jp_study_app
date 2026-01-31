import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:jp_study_app/core/theme/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final zen = context.zen;

    return Scaffold(
      backgroundColor: zen.bgPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _HomeNavItem(
              title: '五十音',
              subtitle: 'かな',
              onTap: () => context.push('/kana'),
              zen: zen,
            ),
            SizedBox(height: zen.spacing.xxl),
            _HomeNavItem(
              title: '單字',
              subtitle: 'ことば',
              onTap: () => context.push('/vocabulary'),
              zen: zen,
            ),
            SizedBox(height: zen.spacing.xxl),
            _HomeNavItem(
              title: '測驗',
              subtitle: 'しけん',
              onTap: () => context.push('/exam_setup'),
              zen: zen,
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
  final ZenTheme zen;

  const _HomeNavItem({
    required this.title,
    required this.subtitle,
    this.onTap,
    required this.zen,
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
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w300,
              color: isEnabled
                  ? zen.textPrimary
                  : zen.textPrimary.withValues(alpha: 0.2),
              letterSpacing: zen.layout.letterSpacingHuge,
            ),
          ),
          SizedBox(height: zen.spacing.sm),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w400,
              color: isEnabled
                  ? zen.textSecondary.withValues(alpha: 0.7)
                  : zen.textSecondary.withValues(alpha: 0.1),
              letterSpacing: zen.layout.letterSpacingLarge,
            ),
          ),
        ],
      ),
    );
  }
}

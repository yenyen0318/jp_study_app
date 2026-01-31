import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// 標準的頁面標題組件
class ZenPageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final double? letterSpacing;

  const ZenPageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.letterSpacing = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    final zen = context.zen;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: textTheme.headlineMedium?.copyWith(
                  color: zen.textPrimary,
                  letterSpacing: letterSpacing,
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
        if (subtitle != null) ...[
          SizedBox(height: zen.spacing.xs),
          Text(
            subtitle!,
            style: textTheme.bodyMedium?.copyWith(
              color: zen.textSecondary.withValues(alpha: 0.7),
            ),
          ),
        ],
      ],
    );
  }
}

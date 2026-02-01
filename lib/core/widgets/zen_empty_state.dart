import 'package:flutter/material.dart';
import 'package:jp_study_app/core/theme/theme.dart';

/// 禪意空白狀態元件
///
/// 提供溫暖且不干擾的空白狀態引導,符合極簡設計原則。
///
/// 設計理念:
/// - 零圖標設計,追求極致留白
/// - 溫暖的繁體中文引導語句
/// - 保持視覺輕盈與呼吸感
class ZenEmptyState extends StatelessWidget {
  /// 主要提示訊息
  final String message;

  /// 次要說明訊息(可選)
  final String? subtitle;

  const ZenEmptyState({super.key, required this.message, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final zen = context.zen;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(zen.spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 主要訊息
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(
                color: zen.textSecondary,
                fontWeight: FontWeight.w300,
                height: zen.typography.lineHeightRelaxed,
              ),
            ),

            // 次要說明
            if (subtitle != null) ...[
              SizedBox(height: zen.spacing.sm),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: zen.textSecondary.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w300,
                  height: zen.typography.lineHeightRelaxed,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

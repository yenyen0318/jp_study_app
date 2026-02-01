import 'package:flutter/material.dart';
import 'package:jp_study_app/core/theme/theme.dart';

/// 禪意錯誤狀態元件
///
/// 提供溫和且不引發焦慮的錯誤狀態提示,符合「安靜書僮」理念。
///
/// 設計理念:
/// - 避免「失敗」用詞,不使用「錯誤」、「失敗」、「無法」等負面詞彙
/// - 零圖標設計,減少視覺噪音
/// - 色彩極淡,不使用紅色或警示色,維持灰階系統
/// - 語氣溫暖,像朋友般的口吻
class ZenErrorState extends StatelessWidget {
  /// 主要提示訊息
  final String message;

  /// 次要說明訊息(可選)
  final String? subtitle;

  const ZenErrorState({super.key, required this.message, this.subtitle});

  /// 預設的一般錯誤狀態
  factory ZenErrorState.general() {
    return const ZenErrorState(
      message: '嗯...好像遇到了一點小問題',
      subtitle: '休息一下,等等再試試吧',
    );
  }

  /// 網路錯誤狀態
  factory ZenErrorState.network() {
    return const ZenErrorState(message: '網路似乎有點不穩定', subtitle: '檢查一下連線,或稍後再來吧');
  }

  /// 載入錯誤狀態
  factory ZenErrorState.loading() {
    return const ZenErrorState(
      message: '內容準備時遇到了阻礙',
      subtitle: '別擔心,重新整理可能就好了',
    );
  }

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

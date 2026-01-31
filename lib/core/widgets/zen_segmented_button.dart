import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:jp_study_app/core/theme/theme.dart';

/// Zen 風格的 Segmented Button (單選元件)
///
/// 適用場景: 2-4 個選項的單選,通常用於模式切換或類型切換
///
/// 視覺特徵:
/// - 整體外框包裹設計
/// - 選項之間使用極細分隔線
/// - 選中項填充背景色,未選中項透明背景
/// - 符合禪意美學的動畫過渡
///
/// 範例:
/// ```dart
/// ZenSegmentedButton<String>(
///   options: ['選項一', '選項二', '選項三'],
///   selectedValue: _selectedValue,
///   onChanged: (value) => setState(() => _selectedValue = value),
///   theme: zenTheme,
/// )
/// ```
class ZenSegmentedButton<T> extends StatelessWidget {
  /// 選項列表
  final List<T> options;

  /// 當前選中的值
  final T selectedValue;

  /// 值變更回調
  final ValueChanged<T> onChanged;

  /// Zen 主題
  final ZenTheme theme;

  /// 選項標籤生成器 (可選,預設使用 toString())
  final String Function(T)? labelBuilder;

  const ZenSegmentedButton({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    required this.theme,
    this.labelBuilder,
  }) : assert(
         options.length >= 2 && options.length <= 4,
         'ZenSegmentedButton 應該有 2-4 個選項',
       );

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(theme.radius.lg),
          border: Border.all(color: theme.borderSubtle, width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            options.length * 2 - 1, // 選項 + 分隔線
            (index) {
              if (index.isOdd) {
                // 分隔線
                return Container(
                  width: 0.5,
                  height: 32,
                  color: theme.borderSubtle,
                );
              } else {
                // 選項按鈕
                final optionIndex = index ~/ 2;
                final option = options[optionIndex];
                final isSelected = option == selectedValue;
                final isFirst = optionIndex == 0;
                final isLast = optionIndex == options.length - 1;

                return Flexible(
                  child: _SegmentButton(
                    label: labelBuilder?.call(option) ?? option.toString(),
                    isSelected: isSelected,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onChanged(option);
                    },
                    theme: theme,
                    isFirst: isFirst,
                    isLast: isLast,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

/// Segmented Button 的單個按鈕
class _SegmentButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final ZenTheme theme;
  final bool isFirst;
  final bool isLast;

  const _SegmentButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.theme,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.horizontal(
        left: isFirst ? Radius.circular(theme.radius.lg) : Radius.zero,
        right: isLast ? Radius.circular(theme.radius.lg) : Radius.zero,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? theme.textPrimary : Colors.transparent,
          borderRadius: BorderRadius.horizontal(
            left: isFirst ? Radius.circular(theme.radius.lg) : Radius.zero,
            right: isLast ? Radius.circular(theme.radius.lg) : Radius.zero,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: isSelected ? theme.bgSurface : theme.textSecondary,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
              fontSize: 13, // 微調以適應 Segmented Button
            ),
          ),
        ),
      ),
    );
  }
}

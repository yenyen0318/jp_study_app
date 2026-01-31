import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_study_app/core/theme/theme.dart';

/// Zen 風格的 Chip Selector (單選元件)
///
/// 適用場景: 3+ 個選項的單選,通常用於分類選擇或篩選
///
/// 視覺特徵:
/// - 獨立的 Chip 設計
/// - 選中項填充背景色,未選中項使用表面色
/// - 支援水平捲動
/// - 符合禪意美學的動畫過渡
///
/// 範例:
/// ```dart
/// ZenChipSelector<String>(
///   options: ['全部', '清音', '濁音', '半濁音', '拗音'],
///   selectedValue: _selectedCategory,
///   onChanged: (value) => setState(() => _selectedCategory = value),
///   theme: zenTheme,
/// )
/// ```
class ZenChipSelector<T> extends StatelessWidget {
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

  const ZenChipSelector({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    required this.theme,
    this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options.map((option) {
          final isSelected = option == selectedValue;
          final label = labelBuilder?.call(option) ?? option.toString();

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                HapticFeedback.selectionClick();
                onChanged(option);
              },
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? theme.textPrimary : theme.bgSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : theme.borderSubtle,
                    width: 0.5,
                  ),
                ),
                child: Text(
                  label,
                  style: GoogleFonts.notoSansTc(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
                    color: isSelected ? theme.bgPrimary : theme.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

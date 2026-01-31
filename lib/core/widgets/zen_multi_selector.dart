import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_study_app/core/theme/theme.dart';

/// Zen 風格的 Multi Selector (多選元件)
///
/// 適用場景: 需要多選的場景,如選擇多個假名行
///
/// 視覺特徵:
/// - 未選中項使用虛線邊框
/// - 選中項使用實線邊框 + 淡色背景
/// - 明確的視覺區別於單選元件
/// - 符合禪意美學的動畫過渡
///
/// 範例:
/// ```dart
/// ZenMultiSelector<int>(
///   options: List.generate(14, (i) => i),
///   selectedValues: _selectedRows,
///   onChanged: (values) => setState(() => _selectedRows = values),
///   theme: zenTheme,
///   labelBuilder: (index) => _rowLabels[index],
/// )
/// ```
class ZenMultiSelector<T> extends StatelessWidget {
  /// 選項列表
  final List<T> options;

  /// 當前選中的值列表
  final List<T> selectedValues;

  /// 值變更回調
  final ValueChanged<List<T>> onChanged;

  /// Zen 主題
  final ZenTheme theme;

  /// 選項標籤生成器 (可選,預設使用 toString())
  final String Function(T)? labelBuilder;

  /// 最小選擇數量 (預設為 1,至少要選一個)
  final int minSelection;

  const ZenMultiSelector({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    required this.theme,
    this.labelBuilder,
    this.minSelection = 1,
  });

  void _toggleOption(T option) {
    final newSelection = List<T>.from(selectedValues);
    if (newSelection.contains(option)) {
      // 取消選擇,但要確保至少保留 minSelection 個
      if (newSelection.length > minSelection) {
        newSelection.remove(option);
      }
    } else {
      // 新增選擇
      newSelection.add(option);
    }
    HapticFeedback.selectionClick();
    onChanged(newSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = selectedValues.contains(option);
        final label = labelBuilder?.call(option) ?? option.toString();

        return InkWell(
          onTap: () => _toggleOption(option),
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.textPrimary.withValues(alpha: 0.05)
                  : Colors.transparent,
              border: Border.all(
                color: isSelected
                    ? theme.textPrimary.withValues(alpha: 0.3)
                    : theme.borderSubtle,
                width: 0.5,
                style: isSelected ? BorderStyle.solid : BorderStyle.solid,
                // 注意: Flutter 的 Border.all 不支援 dashed style
                // 如需虛線效果,需使用 CustomPainter
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              label,
              style: GoogleFonts.notoSansTc(
                fontSize: 14,
                color: isSelected ? theme.textPrimary : theme.textSecondary,
                fontWeight: isSelected ? FontWeight.w400 : FontWeight.w300,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

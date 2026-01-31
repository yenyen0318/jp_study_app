import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/exam/domain/entities/quiz.dart';
import 'package:jp_study_app/features/exam/presentation/providers/exam_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:jp_study_app/core/widgets/zen_button.dart';

class ExamScopeDialog extends ConsumerStatefulWidget {
  const ExamScopeDialog({super.key});

  @override
  ConsumerState<ExamScopeDialog> createState() => _ExamScopeDialogState();
}

class _ExamScopeDialogState extends ConsumerState<ExamScopeDialog> {
  final List<int> _selectedRows = [0]; // 預設選中あ行
  final List<String> _selectedTypes = ['hiragana'];
  bool _isRandomSampling = false; // 驗收模式：false=完整覆蓋, true=隨機抽樣

  final _rows = [
    'あ行',
    'か行',
    'さ行',
    'た行',
    'な行',
    'は行',
    'ま行',
    'や行',
    'ら行',
    'わ行',
    '鼻音 (ん)',
    '濁音 (が行~ば行)',
    '半濁音 (ぱ行)',
    '拗音 (きゃ~ぴょ)',
  ];

  void _toggleRow(int index) {
    setState(() {
      if (_selectedRows.contains(index)) {
        if (_selectedRows.length > 1) _selectedRows.remove(index);
      } else {
        _selectedRows.add(index);
      }
    });
  }

  void _toggleType(String type) {
    setState(() {
      if (_selectedTypes.contains(type)) {
        if (_selectedTypes.length > 1) _selectedTypes.remove(type);
      } else {
        _selectedTypes.add(type);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ZenTheme>()!;

    return Dialog(
      backgroundColor: theme.bgSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '選擇驗收範圍',
              style: GoogleFonts.notoSansTc(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: theme.textPrimary,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 24),

            // 類型選擇 (平假名/片假名)
            Row(
              children: [
                _TypeChip(
                  label: '平假名',
                  isSelected: _selectedTypes.contains('hiragana'),
                  onTap: () => _toggleType('hiragana'),
                  theme: theme,
                ),
                const SizedBox(width: 12),
                _TypeChip(
                  label: '片假名',
                  isSelected: _selectedTypes.contains('katakana'),
                  onTap: () => _toggleType('katakana'),
                  theme: theme,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 行選擇矩陣
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_rows.length, (index) {
                final isSelected = _selectedRows.contains(index);
                return InkWell(
                  onTap: () => _toggleRow(index),
                  borderRadius: BorderRadius.circular(8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.textPrimary.withValues(alpha: 0.05)
                          : Colors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? theme.textPrimary.withValues(alpha: 0.3)
                            : theme.borderSubtle,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _rows[index],
                      style: GoogleFonts.notoSansTc(
                        fontSize: 14,
                        color: isSelected
                            ? theme.textPrimary
                            : theme.textSecondary,
                        fontWeight: isSelected
                            ? FontWeight.w400
                            : FontWeight.w300,
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            // 驗收模式選擇（使用 Segmented Button 表達單選語意）
            _ModeSegmentedButton(
              isRandomSampling: _isRandomSampling,
              onModeChanged: (isRandom) =>
                  setState(() => _isRandomSampling = isRandom),
              theme: theme,
            ),

            const SizedBox(height: 32),

            // 開始按鈕
            ZenButton(
              label: '開始',
              onPressed: () {
                // 處理行索引映射：將 UI 上的索引轉換為資料庫中實際的 row 索引
                final Set<int> actualRows = {};
                for (final index in _selectedRows) {
                  if (index == 11) {
                    // 濁音包含 が、ざ、だ、ば 行 (11, 12, 13, 14)
                    actualRows.addAll([11, 12, 13, 14]);
                  } else if (index == 12) {
                    // 半濁音包含 ぱ 行 (15)
                    actualRows.add(15);
                  } else if (index == 13) {
                    // 拗音包含 row 16-26
                    actualRows.addAll(List.generate(11, (i) => i + 16));
                  } else {
                    actualRows.add(index);
                  }
                }

                final scope = ExamScope(
                  types: _selectedTypes,
                  rows: actualRows.toList(),
                  isRandomSampling: _isRandomSampling,
                );
                ref.read(examControllerProvider.notifier).startExam(scope);
                context.pop();
                context.push('/exam');
              },
              theme: theme,
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final ZenTheme theme;

  const _TypeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? theme.textPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? theme.textPrimary : theme.borderSubtle,
            width: 0.5,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.notoSansTc(
            fontSize: 13,
            color: isSelected ? theme.bgSurface : theme.textSecondary,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

/// 驗收模式 Segmented Button（完整覆蓋 / 隨機抽樣）
/// 使用整體式設計明確表達「單選」語意
class _ModeSegmentedButton extends StatelessWidget {
  final bool isRandomSampling;
  final ValueChanged<bool> onModeChanged;
  final ZenTheme theme;

  const _ModeSegmentedButton({
    required this.isRandomSampling,
    required this.onModeChanged,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.borderSubtle, width: 0.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SegmentButton(
              label: '完整覆蓋',
              isSelected: !isRandomSampling,
              onTap: () => onModeChanged(false),
              theme: theme,
              isLeft: true,
            ),
          ),
          Container(width: 0.5, height: 32, color: theme.borderSubtle),
          Expanded(
            child: _SegmentButton(
              label: '隨機 10 題',
              isSelected: isRandomSampling,
              onTap: () => onModeChanged(true),
              theme: theme,
              isLeft: false,
            ),
          ),
        ],
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
  final bool isLeft;

  const _SegmentButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.theme,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.horizontal(
        left: isLeft ? const Radius.circular(20) : Radius.zero,
        right: !isLeft ? const Radius.circular(20) : Radius.zero,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? theme.textPrimary : Colors.transparent,
          borderRadius: BorderRadius.horizontal(
            left: isLeft ? const Radius.circular(20) : Radius.zero,
            right: !isLeft ? const Radius.circular(20) : Radius.zero,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.notoSansTc(
              fontSize: 13,
              color: isSelected ? theme.bgSurface : theme.textSecondary,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}

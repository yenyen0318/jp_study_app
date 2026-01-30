import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/exam/domain/entities/quiz.dart';
import 'package:jp_study_app/features/exam/presentation/providers/exam_controller.dart';
import 'package:go_router/go_router.dart';

class ExamScopeDialog extends ConsumerStatefulWidget {
  const ExamScopeDialog({super.key});

  @override
  ConsumerState<ExamScopeDialog> createState() => _ExamScopeDialogState();
}

class _ExamScopeDialogState extends ConsumerState<ExamScopeDialog> {
  final List<int> _selectedRows = [0]; // 預設選中あ行
  final List<String> _selectedTypes = ['hiragana'];

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
    'ん',
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

            const SizedBox(height: 32),

            // 開始按鈕
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  final scope = ExamScope(
                    types: _selectedTypes,
                    rows: _selectedRows,
                  );
                  ref.read(examControllerProvider.notifier).startExam(scope);
                  context.pop();
                  context.push('/exam');
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: theme.borderSubtle, width: 0.5),
                  ),
                ),
                child: Text(
                  '平靜開始',
                  style: GoogleFonts.notoSansTc(
                    color: theme.textPrimary,
                    fontSize: 16,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
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
          border: isSelected ? null : Border.all(color: theme.borderSubtle),
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
